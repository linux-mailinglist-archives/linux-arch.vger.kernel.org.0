Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC511158E8
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 23:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfLFWAi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 17:00:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34254 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726352AbfLFWAi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Dec 2019 17:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575669635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0/B4QknTAb7E38S4ntzDLzqFl82ozvbtLJr1dzGMzA=;
        b=gwcMzsNgpmWkSohi0K8ndSDprb4qQctIie3w5Bzw+4oPoSR5/3a04L3Dq9koC0eHa7V+kL
        9RykJn/Dm/opz5KPRxH1WeLsdsXZQpNWGUx29HPqqvZ3wZg8kC59KbM12wIjKK1mUTgHFZ
        dfDl7TR2Vyin3j5H0vxk5WVx8G5gGb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-ffAl0DcwMdSijUYqFRNtlA-1; Fri, 06 Dec 2019 17:00:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9C791005512;
        Fri,  6 Dec 2019 22:00:27 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-189.rdu2.redhat.com [10.10.122.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B73515C1D4;
        Fri,  6 Dec 2019 22:00:24 +0000 (UTC)
Subject: Re: [PATCH v7 5/5] locking/qspinlock: Introduce the shuffle reduction
 optimization into CNA
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-6-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1fce5ebf-7f80-fb9e-92b1-74062a6611a5@redhat.com>
Date:   Fri, 6 Dec 2019 17:00:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191125210709.10293-6-alex.kogan@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ffAl0DcwMdSijUYqFRNtlA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/25/19 4:07 PM, Alex Kogan wrote:
> @@ -234,12 +263,13 @@ __always_inline u32 cna_pre_scan(struct qspinlock *=
lock,
>  =09struct cna_node *cn =3D (struct cna_node *)node;
> =20
>  =09/*
> -=09 * setting @pre_scan_result to 1 indicates that no post-scan
> +=09 * setting @pre_scan_result to 1 or 2 indicates that no post-scan
>  =09 * should be made in cna_pass_lock()
>  =09 */
>  =09cn->pre_scan_result =3D
> -=09=09cn->intra_count =3D=3D intra_node_handoff_threshold ?
> -=09=09=091 : cna_scan_main_queue(node, node);
> +=09=09(node->locked <=3D 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) ?
> +=09=09=091 : cn->intra_count =3D=3D intra_node_handoff_threshold ?
> +=09=09=092 : cna_scan_main_queue(node, node);
> =20
>  =09return 0;
>  }
> @@ -253,12 +283,15 @@ static inline void cna_pass_lock(struct mcs_spinloc=
k *node,
> =20
>  =09u32 scan =3D cn->pre_scan_result;
> =20
> +=09if (scan =3D=3D 1)
> +=09=09goto pass_lock;
> +
>  =09/*
>  =09 * check if a successor from the same numa node has not been found in
>  =09 * pre-scan, and if so, try to find it in post-scan starting from the
>  =09 * node where pre-scan stopped (stored in @pre_scan_result)
>  =09 */
> -=09if (scan > 1)
> +=09if (scan > 2)
>  =09=09scan =3D cna_scan_main_queue(node, decode_tail(scan));
> =20
>  =09if (!scan) { /* if found a successor from the same numa node */
> @@ -281,5 +314,6 @@ static inline void cna_pass_lock(struct mcs_spinlock =
*node,
>  =09=09tail_2nd->next =3D next;
>  =09}
> =20
> +pass_lock:
>  =09arch_mcs_pass_lock(&next_holder->locked, val);
>  }

I think you might have mishandled the proper accounting of intra_count.
How about something like:

diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.=
h
index f1eef6bece7b..03f8fdec2b80 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -268,7 +268,7 @@ __always_inline u32 cna_pre_scan(struct qspinlock *lock=
,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cn->pre_scan_result =3D
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (node->locked <=3D 1 &&
probably(SHUFFLE_REDUCTION_PROB_ARG)) ?
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 : cn->intra_=
count =3D=3D
intra_node_handoff_threshold ?
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 : cn->intra_=
count >=3D
intra_node_handoff_threshold ?
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 : cna_sca=
n_main_queue(node, node);
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
@@ -283,9 +283,6 @@ static inline void cna_pass_lock(struct mcs_spinlock
*node,
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 scan =3D cn->pre_scan_result=
;
=C2=A0
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scan =3D=3D 1)
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 goto pass_lock;
-
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * check if a successor fro=
m the same numa node has not been
found in
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * pre-scan, and if so, try=
 to find it in post-scan starting
from the
@@ -294,7 +291,13 @@ static inline void cna_pass_lock(struct
mcs_spinlock *node,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scan > 2)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 scan =3D cna_scan_main_queue(node, decode_tail(scan));
=C2=A0
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!scan) { /* if found a successor =
from the same numa node */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scan <=3D 1) { /* if found a succ=
essor from the same numa node */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* inc @intra_count if the secondary queue is not empty */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ((struct cna_node *)next_holder)->intra_count =3D
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cn->intra_coun=
t + (node->locked > 1);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if ((scan =3D=3D 1)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto pass_lock=
;
+
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 next_holder =3D node->next;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /*
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * we unlock successor by passing a non-zero value,
@@ -302,9 +305,6 @@ static inline void cna_pass_lock(struct mcs_spinlock
*node,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * if we acquired the MCS lock when its queue was empt=
y
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 val =3D node->locked ? node->locked : 1;
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* inc @intra_count if the secondary queue is not empty */
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ((struct cna_node *)next_holder)->intra_count =3D
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cn->intra_coun=
t + (node->locked > 1);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (node->locked > 1) {=
=C2=A0=C2=A0=C2=A0 /* if secondary queue is not
empty */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* next holder will be the first node in the secondary
queue */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 tail_2nd =3D decode_tail(node->locked);

The meaning of scan value:

0 - pass to next cna node, which is in the same numa node. Additional
cna node may or may not be added to the secondary queue

1 - pass to next cna node, which may not be in the same numa node. No
change to secondary queue

2 - exceed intra node handoff threshold, unconditionally merge back the
secondary queue cna nodes, if available

>2 no cna node of the same numa node found, unconditionally merge back
the secondary queue cna nodes, if available

The code will be easier to read if symbolic names instead of just numbers.

Cheers,
Longman


