Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C6CE07DC
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2019 17:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbfJVPtY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Oct 2019 11:49:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54372 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388435AbfJVPtQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Oct 2019 11:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571759354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=soPvBg70/+oC8uencQegA6z5y64aNbKflTrsxEmRfUE=;
        b=bp5PmL+R633SlveIxj6b4+pycNt01m+rfqq8xxuo7oZlgSKIzNqfbQKEwhzRHuJZKZgoIc
        7rgDNokYLXGXI8b7n9zLL+WUYv/1dxyghnWIMjB2tOjee2Qq7KOCmj8DKbJhJ4RXmnhAUH
        nI4G88EZjgCC8qjD37IOg7rakhUtTwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-pP--3crAMhSTJdyaJUkLUQ-1; Tue, 22 Oct 2019 11:49:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64FA5800D49;
        Tue, 22 Oct 2019 15:49:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 88EE560C57;
        Tue, 22 Oct 2019 15:48:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 22 Oct 2019 17:49:06 +0200 (CEST)
Date:   Tue, 22 Oct 2019 17:48:58 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Marco Elver <elver@google.com>
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 1/8] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Message-ID: <20191022154858.GA13700@redhat.com>
References: <20191017141305.146193-1-elver@google.com>
 <20191017141305.146193-2-elver@google.com>
MIME-Version: 1.0
In-Reply-To: <20191017141305.146193-2-elver@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: pP--3crAMhSTJdyaJUkLUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/17, Marco Elver wrote:
>
> +=09/*
> +=09 * Delay this thread, to increase probability of observing a racy
> +=09 * conflicting access.
> +=09 */
> +=09udelay(get_delay());
> +
> +=09/*
> +=09 * Re-read value, and check if it is as expected; if not, we infer a
> +=09 * racy access.
> +=09 */
> +=09switch (size) {
> +=09case 1:
> +=09=09is_expected =3D expect_value._1 =3D=3D READ_ONCE(*(const u8 *)ptr)=
;
> +=09=09break;
> +=09case 2:
> +=09=09is_expected =3D expect_value._2 =3D=3D READ_ONCE(*(const u16 *)ptr=
);
> +=09=09break;
> +=09case 4:
> +=09=09is_expected =3D expect_value._4 =3D=3D READ_ONCE(*(const u32 *)ptr=
);
> +=09=09break;
> +=09case 8:
> +=09=09is_expected =3D expect_value._8 =3D=3D READ_ONCE(*(const u64 *)ptr=
);
> +=09=09break;
> +=09default:
> +=09=09break; /* ignore; we do not diff the values */
> +=09}
> +
> +=09/* Check if this access raced with another. */
> +=09if (!remove_watchpoint(watchpoint)) {
> +=09=09/*
> +=09=09 * No need to increment 'race' counter, as the racing thread
> +=09=09 * already did.
> +=09=09 */
> +=09=09kcsan_report(ptr, size, is_write, smp_processor_id(),
> +=09=09=09     kcsan_report_race_setup);
> +=09} else if (!is_expected) {
> +=09=09/* Inferring a race, since the value should not have changed. */
> +=09=09kcsan_counter_inc(kcsan_counter_races_unknown_origin);
> +#ifdef CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
> +=09=09kcsan_report(ptr, size, is_write, smp_processor_id(),
> +=09=09=09     kcsan_report_race_unknown_origin);
> +#endif
> +=09}

Not sure I understand this code...

Just for example. Suppose that task->state =3D TASK_UNINTERRUPTIBLE, this t=
ask
does __set_current_state(TASK_RUNNING), another CPU does wake_up_process(ta=
sk)
which does the same UNINTERRUPTIBLE -> RUNNING transition.

Looks like, this is the "data race" according to kcsan?

Hmm. even the "if (!(p->state & state))" check in try_to_wake_up() can trig=
ger
kcsan_report() ?

Oleg.

