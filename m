Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366922C4759
	for <lists+linux-arch@lfdr.de>; Wed, 25 Nov 2020 19:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbgKYSOy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Nov 2020 13:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730643AbgKYSOy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Nov 2020 13:14:54 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE93AC0613D4;
        Wed, 25 Nov 2020 10:14:53 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id m13so3040895ioq.9;
        Wed, 25 Nov 2020 10:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NIpG45UWwddpGV+62KwVJM4R9vkmQaVM+kUHYytsuOk=;
        b=kWV6G2yZXMm4VSHbnojYmPa+C5P3JnpUTHqE23CMhNkQBQWRzmmhqOLBUtQv2atXCT
         gfx8m7eCmFJ7pVlsuccPiH6QWEPUd8AOsN93MuFELIyPMSRf5jsCMU0WOq//RI0OE3v8
         Xcdy8XkXYHOwwkywVeuV38sTpPsttpVy3JvqUPqjjnzwH11K8V/hcwvS5Z9IHaMrKIUK
         5aPycy8OBpj2x7nvopzyosAyOu5TyhaWlUYzEp+8JqfTnIOXSNZZFCbA0rFGLuslWfdY
         0h9j9VHpYmDhGDt0sVob662k93U0Re/54lGaFjmxi8C+L9fpuTq3YUdx9b9EMjfmYlAP
         xBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NIpG45UWwddpGV+62KwVJM4R9vkmQaVM+kUHYytsuOk=;
        b=eGNs1ZBLBayuVA4HFTYdwRRp2B6JX5sBFZu9gdbQXp7ZkUya3FzV3rNyLsIaXdh2fl
         1hQVdNaU/cI4mn4GB6XdOTFgRjLyBuUNfVBU2Z3gWB7RYJm69S8+NnaWho44nF792gC0
         m9/tuZkaVbKSINvAVLeZLKT1105l/4jdMX2EaRAHu2NQUWMkZiJUZ2p7NZJW7RN0SWjd
         5g/5eUxANUESc3xvKVXaQDvpAGH66XBCSRsdWnA2DeB/mEBI//RsTVYavGsCHo9s6O58
         TtbjsxqiahEdB+eL3UWU6sF1XuHw5r6SL2FNZgNfVIHPIzvePpZQ1RHKLz8pDGjqmEfC
         N8uA==
X-Gm-Message-State: AOAM531jHlFCHk4UC5pcbvGttDLYkCbgoo6zlgxUMds69xaYUmoWI5hh
        vvs65c/j52dhKSxTH0IKtPfC/znq5UeUzz7EIkQ=
X-Google-Smtp-Source: ABdhPJy4bdnOlLLsyDMAPulYW5mY6232Uy6n2lvrULm8bBlPIp8KqHJcFEF94nx0UycVv+ODFkxSMwE58yByCsD5otA=
X-Received: by 2002:a5e:a815:: with SMTP id c21mr2793016ioa.141.1606328093153;
 Wed, 25 Nov 2020 10:14:53 -0800 (PST)
MIME-Version: 1.0
References: <30b491ad-a7e1-f7b5-26b8-2cfffc81a080@huawei.com> <CAAH8bW_p3LJPgOoJgUHt6O0run+LB2RbjnAVpeLn_KCAZKNR+A@mail.gmail.com>
In-Reply-To: <CAAH8bW_p3LJPgOoJgUHt6O0run+LB2RbjnAVpeLn_KCAZKNR+A@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 25 Nov 2020 10:14:42 -0800
Message-ID: <CAAH8bW8Zo1U3oMu5Gggp-MyNNZ8_WieQn+GKYiML93O9sJB=Dg@mail.gmail.com>
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
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 31, 2020 at 11:15 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> On Mon, Aug 31, 2020 at 5:48 AM Xiongfeng Wang
> <wangxiongfeng2@huawei.com> wrote:
> >
> > Hi Yury,
> >
>
> Hi Xiongfeng,
>
> [restore CC list]
>
> Haven't seen this before. What kernel / glibc / ltp do you use?
>
> > We were testing the ILP32 feature and came accross a problem. Very apperaciate
> > it if you could give us some help !
> >
> > We compile the LTP testsuite with '-mabi=ilp32' and run it on a machine with
> > kernel and glibc applied with ILP32 patches. But we failed on one testcase,
> > prctl04. It print the following error info.
> > 'prctl04.c:199: FAIL: SECCOMP_MODE_STRICT doesn't permit read(2) write(2) and
> > _exit(2)'
> >
> > The testcase is like below, syscall 'prctl' followed by a syscall 'write'.
> > prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT);
> > SAFE_WRITE(1, fd, "a", 1);
> >
> > When we execute syscall 'write', we receive a SIGKILL. It's not as expected.
> > We track the kernel and found out it is because we failed the syscall_whitelist
> > check in '__secure_computing_strict'. Because flag 'TIF_32BIT_AARCH64' is set,
> > we falls into the 'in_compat_syscall()' branch. We compare the parameter
> > 'this_syscall' with return value of 'get_compat_model_syscalls()'
> > The syscall number of '__NR_write' for ilp32 application is 64, but it is 4 for
> > 'model_syscalls_32' returned from 'get_compat_model_syscalls()'
> > So '__secure_computing_strict' retuned with 'do_exit(SIGKILL)'. We have a
> > modification like below, but I am not sure if it correct or not.
> >
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -618,7 +618,7 @@ static void __secure_computing_strict(int this_syscall)
> >  {
> >         const int *syscall_whitelist = mode1_syscalls;
> >  #ifdef CONFIG_COMPAT
> > -       if (in_compat_syscall())
> > +       if (is_a32_compat_task())
> >                 syscall_whitelist = get_compat_mode1_syscalls();
>
> It calls the arch function from generic code. It may break build for
> other arches.
> This also looks dangerous because it treats ILP32 execution as non-compat.
>
> The right approach would be implementing arch-specific
> get_compat_mode1_syscalls()
> in arch/arm64/include/asm/seccomp.h that returns an appropriate table.
> Refer MIPS
> code for this: arch/mips/include/asm/seccomp.h
>
> Thanks,
> Yury
>
> >  #endif
> >         do {
> >
> >
> > Thanks,
> > Xiongfeng
> >

The fix is on my repo; versions 5.2 and 4.19 are updated:

https://github.com/norov/linux/commits/ilp32-4.19
https://github.com/norov/linux/commits/ilp32-5.2
