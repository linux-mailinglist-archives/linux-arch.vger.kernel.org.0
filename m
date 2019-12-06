Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B7A1156F6
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 19:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFSJv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 13:09:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34128 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726298AbfLFSJu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Dec 2019 13:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575655789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3VZZxlbfAl35SR1EmYLDv6VWCiuxdAqaC9PNp/DzVJA=;
        b=JbDFtTQF2TVGPIy010HMzDR1lmR4XYv6OLrFcE/fp+o7JKwzV/0r1mr4toGazNzFkSwGHz
        +ORrwPiq4ZJ4TcMHJ97taycYo7bC6qj6drVZv/mLM0P2B7Rwo9LGjAB5FB4+K1OOl7s2xL
        4iE4EL2WDjX5ybu/DgK9F0wiDSOTHPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-Itt7ODuhPIm0UsPz6aKcCA-1; Fri, 06 Dec 2019 13:09:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDFF8107ACC4;
        Fri,  6 Dec 2019 18:09:43 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-189.rdu2.redhat.com [10.10.122.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4976B5D6BB;
        Fri,  6 Dec 2019 18:09:41 +0000 (UTC)
Subject: Re: [PATCH v7 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-5-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <3d06a43e-0cf7-dc47-a2c7-7a9145a29ad5@redhat.com>
Date:   Fri, 6 Dec 2019 13:09:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191125210709.10293-5-alex.kogan@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Itt7ODuhPIm0UsPz6aKcCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/25/19 4:07 PM, Alex Kogan wrote:
> Keep track of the number of intra-node lock handoffs, and force
> inter-node handoff once this number reaches a preset threshold.
> The default value for the threshold can be overridden with
> the new kernel boot command-line option "numa_spinlock_threshold".
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  8 ++++++
>  arch/x86/kernel/alternative.c                 | 27 +++++++++++++++++++
>  kernel/locking/qspinlock.c                    |  3 +++
>  kernel/locking/qspinlock_cna.h                | 27 ++++++++++++++++---
>  4 files changed, 62 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 904cb32f592d..887fbfce701d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3185,6 +3185,14 @@
>  =09=09=09Not specifying this option is equivalent to
>  =09=09=09numa_spinlock=3Dauto.
> =20
> +=09numa_spinlock_threshold=3D=09[NUMA, PV_OPS]
> +=09=09=09Set the threshold for the number of intra-node
> +=09=09=09lock hand-offs before the NUMA-aware spinlock
> +=09=09=09is forced to be passed to a thread on another NUMA node.
> +=09=09=09Valid values are in the [0..31] range. Smaller values
> +=09=09=09result in a more fair, but less performant spinlock, and
> +=09=09=09vice versa. The default value is 16.
> +
>  =09cpu0_hotplug=09[X86] Turn on CPU0 hotplug feature when
>  =09=09=09CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
>  =09=09=09Some features depend on CPU0. Known dependencies are:
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
> index 6a4ccbf4e09c..28552e0491b5 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -723,6 +723,33 @@ static int __init numa_spinlock_setup(char *str)
> =20
>  __setup("numa_spinlock=3D", numa_spinlock_setup);
> =20
> +/*
> + * Controls the threshold for the number of intra-node lock hand-offs be=
fore
> + * the NUMA-aware variant of spinlock is forced to be passed to a thread=
 on
> + * another NUMA node. By default, the chosen value provides reasonable
> + * long-term fairness without sacrificing performance compared to a lock
> + * that does not have any fairness guarantees.
> + */
> +int intra_node_handoff_threshold =3D 1 << 16;

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __ro_after_init

> +
> +static int __init numa_spinlock_threshold_setup(char *str)
> +{
> +=09int new_threshold_param;
> +
> +=09if (get_option(&str, &new_threshold_param)) {
> +=09=09/* valid value is between 0 and 31 */
> +=09=09if (new_threshold_param < 0 || new_threshold_param > 31)
> +=09=09=09return 0;
> +
> +=09=09intra_node_handoff_threshold =3D 1 << new_threshold_param;
> +=09=09return 1;
> +=09}
> +
> +=09return 0;
> +}
> +
> +__setup("numa_spinlock_threshold=3D", numa_spinlock_threshold_setup);
> +
>  #endif
> =20

Against, this should be in qspinlock_can.h not in alternative.c.

Cheers,
Longman

