Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F712254FB
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jul 2020 02:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgGTAiV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Jul 2020 20:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgGTAiV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jul 2020 20:38:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BFEC0619D2;
        Sun, 19 Jul 2020 17:38:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s26so8204317pfm.4;
        Sun, 19 Jul 2020 17:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:mime-version:message-id
         :content-transfer-encoding;
        bh=XFq1tbFsgX2AZdMgYvw8N+gQKnN3+VgEwdSA0SX4/tw=;
        b=mKUpi/C/VrbkHgaAlfwHD+1TzhYa5ul9sEEkCLJouYkaK5jdWeGoRgaXfbw07dzvX2
         NzyjGf4e8K0QeJ2EDCqXqSQJIOSUgchdsOZcx6pUC26pIDCvP5XCwEsy4wIRtUaVmzrr
         kPZGnmnUm1qxmh2p4NkAaXSIxKcrHlAWA1EfQ2ayfOL3U1OuCne6OD72Yug7GE646uuP
         Mk9QZhIb+UM3SQFn5yCYG0ubBU7qfQjsAnANXBJdGyHYKz4U9e3x9t0aJFNQLYwVTGzN
         MY3+Hn7teHGvhHaBOLkQmK16Rj4yVCZEc1OdpXfMwapUOQoZyox8ZEh2W2gj5N/T//Hn
         Vh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:mime-version:message-id
         :content-transfer-encoding;
        bh=XFq1tbFsgX2AZdMgYvw8N+gQKnN3+VgEwdSA0SX4/tw=;
        b=syZ0nG86x5KI5/qw0BrtFd32IJlISdmmX19e6QQbQgf90R+95Q+Uf71hPDtqnAJk52
         312gAMAtObuqftm7Nj1Gq5gb5ihAhcN2F5bowgRHNeXxxi2Q3jX4KAG30l//W5olrkE2
         SvY42v5h/tF0P+f7y4Ewhr5svRo9xKTNoDfImWgP/MIuyUzjVVs/1ofnpvr83zRKVFgw
         p+QR5hlkdMd9ZTtx/uZ3uZSObDHLJfUhrC7lc37ByDWSgPhQAm+VTPkT1MFMG8TDheh2
         8A9/uSbEUCzwBTtn8VnyyJJLiPLhQp5lXBP0uLuux8OKx/Xm1orItktaK7HgY/cSOEor
         hWaQ==
X-Gm-Message-State: AOAM5307JgEFnPjMICYHXajAuqcoLTn/9GckWeaMsk640UH6z0GAsLn1
        YMNFR+LB3wVf6/4jzYAc2tw=
X-Google-Smtp-Source: ABdhPJwKnuIipkmIajupZTNxeEfnOBQT2VjNliL94btuuxQncHtcH3EQkViU0lPNZOjdJTZ6aogM6g==
X-Received: by 2002:a05:6a00:1596:: with SMTP id u22mr17321339pfk.102.1595205500660;
        Sun, 19 Jul 2020 17:38:20 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id z11sm14633320pfk.46.2020.07.19.17.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 17:38:20 -0700 (PDT)
Date:   Mon, 20 Jul 2020 10:38:15 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: io_uring kthread_use_mm / mmget_not_zero possible abuse
To:     Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Message-Id: <1595203632.x8vplwce1a.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When I last looked at this (predating io_uring), as far as I remember it wa=
s=20
not permitted to actually switch to (use_mm) an mm user context that was=20
pinned with mmget_not_zero. Those pins were only allowed to look at page=20
tables, vmas, etc., but not actually run the CPU in that mm context.

sparc/kernel/smp_64.c depends heavily on this, e.g.,

void smp_flush_tlb_mm(struct mm_struct *mm)
{
        u32 ctx =3D CTX_HWBITS(mm->context);
        int cpu =3D get_cpu();

        if (atomic_read(&mm->mm_users) =3D=3D 1) {
                cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
                goto local_flush_and_out;
        }

        smp_cross_call_masked(&xcall_flush_tlb_mm,
                              ctx, 0, 0,
                              mm_cpumask(mm));

local_flush_and_out:
        __flush_tlb_mm(ctx, SECONDARY_CONTEXT);

        put_cpu();
}

If a kthread comes in concurrently between the mm_users test and the=20
mm_cpumask reset, and does mmget_not_zero(); kthread_use_mm() then we have=20
another CPU switched to mm context but not in the mm_cpumask. It's then=20
possible for our thread to schedule on that CPU and not go through a=20
switch_mm (because kthread_unuse_mm will make it lazy, then we can switch=20
back to our user thread and un-lazy it).

powerpc has something similar.

I don't think this is documented anywhere and certainly isn't checked for=20
unfortunately, so I don't really blame io_uring.

The simplest fix is for io_uring to carry mm_users references. If that can'=
t=20
be done or we decide to lift the limitation on mmget_not_zero references, w=
e=20
can come up with a way to synchronize things.

On powerpc for example, we IPI all targets in mm_cpumask before clearing=20
them, so we could disable interrupts while kthread_use_mm does the mm switc=
h=20
sequence, and have the IPI handler check that current->mm hasn't been set t=
o=20
mm, for example.

sparc is a bit harder because it doesn't IPI targets if it thinks it can=20
avoid it. But powerpc found that just doing one IPI isn't a big burden here=
=20
so maybe we change sparc to do that too. I would be inclined to fix this=20
mmget_not_zero quirk if we can, unless someone has a very good way to test=20
and enforce it, it'll just happen again.

Comments?

Thanks,
Nick
