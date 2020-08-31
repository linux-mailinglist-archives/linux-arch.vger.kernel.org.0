Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DBA258087
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 20:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgHaSPH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 14:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgHaSPG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2020 14:15:06 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F697C061573;
        Mon, 31 Aug 2020 11:15:06 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z25so4293649iol.10;
        Mon, 31 Aug 2020 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gSAPrDjVFU9gx8jAU0bnZ1hQWEfjuAFbMKOLGx6XL4=;
        b=dJV28rHReMIEvJ1D3zsEscE+DsFUT1m/nULxUyByVga8DkFPnloOowvZvym7qghYpN
         Y7dNsaJ/aSlrx+Oo8e5K4bJqr0FySaidW2HFo4HqwGB9NP2etFNV4mMGCKWZy4/1tjzs
         Xj4SnLWQWOGQOg2Kv9GgCIgjHmzz/Ic4Azk+72s+KpFI3/v/b6luB7Xgdv3dexK19aQE
         AiVY6wXxcZuis0xXHMVC2Gx7dR/wlIGH46Wv7IgVwSoEgSKLFfp8thPlFfpKmFLlNyEV
         nRG4A+87hfEMLDWf9oPtg7Y0l9BusVF+kD5u7sAIewO3d9Nyjr79TmLAAEecAo88pvSq
         ZGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gSAPrDjVFU9gx8jAU0bnZ1hQWEfjuAFbMKOLGx6XL4=;
        b=PTx9mA1voBFg/3BoAbDDeLTxYHZFJC9/Lw/RHcfi71hbe/qCk3rC2Rq34OdBI2S5Dc
         x8nTS7kY68HBHfM/uSDFcOhCEHxm89GSZcDQVLwDggCieiJp5HSDr4GowzAVhfACIbrH
         GmZlpGBPzAN/w3R4q6yYtwZYNCQTk3462++m4ivd+yoYcCNiZvWCjOA4ssG6zC9RJr4L
         JGWK2jAzI4SIF7Doj058mvezmt3Xz7dP8UOiNcKRCmCHBllY+lDHSiSH8E6YWdo+Txb5
         gO6dJzLCOKori7+R/ivAv8gc9wjY+2LfT2PX2QVUdG1J/+fU236I3iteYI1tojHA/Dnp
         E4tg==
X-Gm-Message-State: AOAM532xfC6jAsaKbIXJNoool1aeAAONXh5kOzFmHBKzY+VJOSVeqtFW
        M1C9eQHaGXbbky5HnqVZMYcapOllzRPVQ+MbsbI=
X-Google-Smtp-Source: ABdhPJxBmDDdCWGh2NgUQ30pW7bEjobvVj0+2EvkprhMPzz2SKBdzcFEdOUrVUHnQ64VGFYe65ZWSRQKGUIj3Mojae0=
X-Received: by 2002:a05:6602:2b13:: with SMTP id p19mr2343159iov.30.1598897705770;
 Mon, 31 Aug 2020 11:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <30b491ad-a7e1-f7b5-26b8-2cfffc81a080@huawei.com>
In-Reply-To: <30b491ad-a7e1-f7b5-26b8-2cfffc81a080@huawei.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Mon, 31 Aug 2020 11:15:00 -0700
Message-ID: <CAAH8bW_p3LJPgOoJgUHt6O0run+LB2RbjnAVpeLn_KCAZKNR+A@mail.gmail.com>
Subject: Re: [Question] About SECCOMP issue for ILP32
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     bobo.shaobowang@huawei.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 31, 2020 at 5:48 AM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> Hi Yury,
>

Hi Xiongfeng,

[restore CC list]

Haven't seen this before. What kernel / glibc / ltp do you use?

> We were testing the ILP32 feature and came accross a problem. Very apperaciate
> it if you could give us some help !
>
> We compile the LTP testsuite with '-mabi=ilp32' and run it on a machine with
> kernel and glibc applied with ILP32 patches. But we failed on one testcase,
> prctl04. It print the following error info.
> 'prctl04.c:199: FAIL: SECCOMP_MODE_STRICT doesn't permit read(2) write(2) and
> _exit(2)'
>
> The testcase is like below, syscall 'prctl' followed by a syscall 'write'.
> prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT);
> SAFE_WRITE(1, fd, "a", 1);
>
> When we execute syscall 'write', we receive a SIGKILL. It's not as expected.
> We track the kernel and found out it is because we failed the syscall_whitelist
> check in '__secure_computing_strict'. Because flag 'TIF_32BIT_AARCH64' is set,
> we falls into the 'in_compat_syscall()' branch. We compare the parameter
> 'this_syscall' with return value of 'get_compat_model_syscalls()'
> The syscall number of '__NR_write' for ilp32 application is 64, but it is 4 for
> 'model_syscalls_32' returned from 'get_compat_model_syscalls()'
> So '__secure_computing_strict' retuned with 'do_exit(SIGKILL)'. We have a
> modification like below, but I am not sure if it correct or not.
>
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -618,7 +618,7 @@ static void __secure_computing_strict(int this_syscall)
>  {
>         const int *syscall_whitelist = mode1_syscalls;
>  #ifdef CONFIG_COMPAT
> -       if (in_compat_syscall())
> +       if (is_a32_compat_task())
>                 syscall_whitelist = get_compat_mode1_syscalls();

It calls the arch function from generic code. It may break build for
other arches.
This also looks dangerous because it treats ILP32 execution as non-compat.

The right approach would be implementing arch-specific
get_compat_mode1_syscalls()
in arch/arm64/include/asm/seccomp.h that returns an appropriate table.
Refer MIPS
code for this: arch/mips/include/asm/seccomp.h

Thanks,
Yury

>  #endif
>         do {
>
>
> Thanks,
> Xiongfeng
>
