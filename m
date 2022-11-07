Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B38461F1C1
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 12:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKGLYv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 06:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiKGLYu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 06:24:50 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2AF1789B
        for <linux-arch@vger.kernel.org>; Mon,  7 Nov 2022 03:24:48 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id io19so10767615plb.8
        for <linux-arch@vger.kernel.org>; Mon, 07 Nov 2022 03:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkXHaDGtvuVhiN69GarlKgDdz00NM6Kt+0lKI4zsZLs=;
        b=P3SUE17FIdMrZVLaiOZj5XVS/b5P9DJZJufnSMg25v9pjcIDMZIQZ4ZR1H0Iz2XFGP
         370EBWXfcGso+1RQsk2HIwlD7yktCzn9piMj2JlEncapGvtB2/WTec7vNx4mjHmtzeWa
         OxoUk9/CEYAm55OESegTyYEG07BFgZka0y6MTFLLA6N0WLTIwRFg6bWdM0sFIBSdIMlF
         Ds0Gvz0G5k3zenG48gpAB51CRzNUzlJZ9qENz4ONaUuJ/1QlUi4/8aDzxE1mVVoUhIOR
         yd54smgQVa+DC4rFbqOEfIpJyRZzfGZcDVcAZj3SOfNtpkx2Xxl2Lo3g0Vl00d1UtejU
         lm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bkXHaDGtvuVhiN69GarlKgDdz00NM6Kt+0lKI4zsZLs=;
        b=7XbIMyPYVBm5vpPOcfOUdcon2s+Io9t7D1JX5RFzk2/+iy69p0irbsANXpPytwdt5Q
         AmjfTMqIMElxxkW3aqHOjG4VfH/RmPlCuTtzqi4tYpSleeLaICeIR1RKNBgvkYG3K6t2
         IfUiBy2fcslpN7mdKdVb9321FstDkp84g1h76nTFUPA6hAp1hkn4tf8LytiIrr9O1lv1
         5dwa+7XSJpR/EmOjfsPwub/QvQB19l2BXZvkrLDkIC+g4u12D+8j0l3i0YbNswDAwfJ2
         2iCAX7x7porGUrvwPFkaFkbhcNsK8dnvPVw8FU6hU4KCo+ahdLSLK8L3r7fnxbFastkB
         sG7Q==
X-Gm-Message-State: ACrzQf1kICjKfcipIlr1aoQkGB7+LgyDFoScOdT7OlT6M4rYaHAAAoBR
        /hw6D/dwaZKuTlQCJ0cwfP9TQEyNBWs=
X-Google-Smtp-Source: AMsMyM7KjokBcg5L0y/OxERq4lN5FFXKLnb6DW/ZfRn6ab/4EpD+J3ir8DKPrYMhPNVnSPTvm6iT4A==
X-Received: by 2002:a17:903:22c9:b0:187:29fe:bda8 with SMTP id y9-20020a17090322c900b0018729febda8mr39108409plg.40.1667820288365;
        Mon, 07 Nov 2022 03:24:48 -0800 (PST)
Received: from localhost (203-221-202-134.tpgi.com.au. [203.221.202.134])
        by smtp.gmail.com with ESMTPSA id z17-20020aa79e51000000b0053e62b6fd22sm4218231pfq.126.2022.11.07.03.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 03:24:47 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 07 Nov 2022 21:24:42 +1000
Message-Id: <CO60Y4MBO8W7.1OSJEIWNIBAHH@bobo>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Cc:     <linuxppc-dev@lists.ozlabs.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Jordan Niethe" <jniethe5@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 0/5] powerpc/kprobes: preempt related changes and
 cleanups
From:   "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.11.0
References: <cover.1666262278.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1666262278.git.naveen.n.rao@linux.vnet.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+linux-arch

FYI most preempt_enable_no_resched() calls outside of core scheduler
code come from kprobes copy-and-paste, and can possibly be fixed in
similar ways as this series. It's a bit of a footgun API that should
be banished from outside kernel/sched/, at least without an explicit
comment for each case that explains the need and how the missed
resched is resolved or not applicable.

Thanks,
Nick

On Fri Oct 21, 2022 at 3:28 AM AEST, Naveen N. Rao wrote:
> This series attempts to address some of the concerns raised in=20
> https://github.com/linuxppc/issues/issues/440
>
> The last two patches are minor cleanups in related kprobes code.
>
> - Naveen
>
>
> Naveen N. Rao (5):
>   powerpc/kprobes: Remove preempt disable around call to get_kprobe() in
>     arch_prepare_kprobe()
>   powerpc/kprobes: Have optimized_callback() use preempt_enable()
>   powerpc/kprobes: Use preempt_enable() rather than the no_resched
>     variant
>   powerpc/kprobes: Setup consistent pt_regs across kprobes, optprobes
>     and KPROBES_ON_FTRACE
>   powerpc/kprobes: Remove unnecessary headers from kprobes
>
>  arch/powerpc/kernel/kprobes-ftrace.c        |  4 ----
>  arch/powerpc/kernel/kprobes.c               | 16 ++++++----------
>  arch/powerpc/kernel/optprobes.c             |  2 +-
>  arch/powerpc/kernel/optprobes_head.S        |  5 +----
>  arch/powerpc/kernel/trace/ftrace_mprofile.S |  6 ++++++
>  5 files changed, 14 insertions(+), 19 deletions(-)
>
>
> base-commit: 7dc2a00fdd44a4d0c3bac9fd10558b3933586a0c
> --=20
> 2.38.0

