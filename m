Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6970141F802
	for <lists+linux-arch@lfdr.de>; Sat,  2 Oct 2021 01:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhJAXGW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 19:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhJAXGP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 19:06:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47491C061775
        for <linux-arch@vger.kernel.org>; Fri,  1 Oct 2021 16:04:30 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r2so10702284pgl.10
        for <linux-arch@vger.kernel.org>; Fri, 01 Oct 2021 16:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=aN3ZAgmq2n3pSx/30jOE16PQorFF/7eTuuFBp43eiXY=;
        b=IYOscUxVH70MZ++sZ08gw+G5qC2G9A4KaPrK30xx7iUzUYOkrtaWLex6rPowT2oJkM
         Zs3AdyB7IydSyAi7JHeMI8UIMlGaybdg3gme2syp0Pw0iS8EWOvZwU4UIHN1RhCVp/Pb
         uDKBfTpbl/2BBoNnH5nRwt5DZPLdF0hSHju+XZbCbvh/ZPIPGFgr5ru+0C4tkB++XXwC
         wxv6P1o08gPYcbU6IkL9La9335csYmGKevZQeOXjXQSAZQ5FOLMiYB15Nkl0VPCq5ikY
         U1NiMfvwVphEDGR2OFr7cbEf7c+QmF+wKwFDrBjU7hWZVvskT0wdAGG7nAOnF8qWRlOC
         558w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=aN3ZAgmq2n3pSx/30jOE16PQorFF/7eTuuFBp43eiXY=;
        b=n9Rf3qKaJVdSR96DKRdMoEelS69Rqzw7fTlKNgWiyLPeJO/IXdcFu+Zen2nJGgo8t0
         IINfWQZp8C/e1wmbkZiwC0vYg+i9aFn7lYv43ZGsihQp62xDnlgIFLAqwmdf0J5rMzVv
         lJmqVCOgq6H/5z6RrBmnRQaBO0QxANolRg4oXgQ008STa+xydUCxsK5e0JsUTVrcUCZD
         mNNW3ZW5YQ7TSGMqbcxuSLEdKUpvZRTqmQhRDLPeWo6fcluB3LSZYxjM3A5ZkCWh3M5n
         s+p5wcMneSd5HztPTXErNql0temJfJlgN4hayGMqlTlW540UBOvtwMJ43KyjyAqfr0Dt
         yt3Q==
X-Gm-Message-State: AOAM530B9/PS37qvFi077qXTASIB7OKPELr7XvDlyczGBG4RpBfBPnzK
        aHfVUNlnG6uLtluOVdyAksFS8w==
X-Google-Smtp-Source: ABdhPJxL8yNIwuo3JLDLT5vfWMMddN1ZLyW6uqopzbArWmPz3RzI4hnI0N6zXbN/slfHyY3vDWH1SQ==
X-Received: by 2002:a63:2cce:: with SMTP id s197mr492444pgs.45.1633129469671;
        Fri, 01 Oct 2021 16:04:29 -0700 (PDT)
Received: from smtpclient.apple ([2600:1010:b06f:1961:6102:acf1:515f:f327])
        by smtp.gmail.com with ESMTPSA id w20sm504149pfc.80.2021.10.01.16.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 16:04:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 11/13] x86/uintr: Introduce uintr_wait() syscall
Date:   Fri, 1 Oct 2021 16:04:27 -0700
Message-Id: <266EFCFB-D0B6-4922-8538-AA3D1146C588@amacapital.net>
References: <875yug4eos.ffs@tglx>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
In-Reply-To: <875yug4eos.ffs@tglx>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (19A346)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Oct 1, 2021, at 2:29 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFOn Fri, Oct 01 2021 at 08:13, Andy Lutomirski wrote:
>=20
>>> On Fri, Oct 1, 2021, at 2:56 AM, Thomas Gleixner wrote:
>>> On Thu, Sep 30 2021 at 21:41, Andy Lutomirski wrote:
>>>>> On Thu, Sep 30, 2021, at 5:01 PM, Thomas Gleixner wrote:
>>>=20
>>>> Now that I read the docs some more, I'm seriously concerned about this
>>>> XSAVE design.  XSAVES with UINTR is destructive -- it clears UINV.  If
>>>> we actually use this, then the whole last_cpu "preserve the state in
>>>> registers" optimization goes out the window.  So does anything that
>>>> happens to assume that merely saving the state doesn't destroy it on
>>>> respectable modern CPUs XRSTORS will #GP if you XRSTORS twice, which
>>>> makes me nervous and would need a serious audit of our XRSTORS paths.
>>>=20
>>> I have no idea what you are fantasizing about. You can XRSTORS five
>>> times in a row as long as your XSTATE memory image is correct.
>>=20
>> I'm just reading TFM, which is some kind of dystopian fantasy.
>>=20
>> 11.8.2.4 XRSTORS
>>=20
>> Before restoring the user-interrupt state component, XRSTORS verifies
>> that UINV is 0. If it is not, XRSTORS causes a general-protection
>> fault (#GP) before loading any part of the user-interrupt state
>> component. (UINV is IA32_UINTR_MISC[39:32]; XRSTORS does not check the
>> contents of the remainder of that MSR.)
>=20
> Duh. I was staring at the SDM and searching for a hint. Stupid me!
>=20
>> So if UINV is set in the memory image and you XRSTORS five times in a
>> row, the first one will work assuming UINV was zero.  The second one
>> will #GP.
>=20
> Yes. I can see what you mean now :)
>=20
>> 11.8.2.3 XSAVES
>> After saving the user-interrupt state component, XSAVES clears UINV. (UIN=
V is IA32_UINTR_MISC[39:32];
>> XSAVES does not modify the remainder of that MSR.)
>>=20
>> So if we're running a UPID-enabled user task and we switch to a kernel
>> thread, we do XSAVES and UINV is cleared.  Then we switch back to the
>> same task and don't do XRSTORS (or otherwise write IA32_UINTR_MISC)
>> and UINV is still clear.
>=20
> Yes, that has to be mopped up on the way to user space.
>=20
>> And we had better clear UINV when running a kernel thread because the
>> UPID might get freed or the kernel thread might do some CPL3
>> shenanigans (via EFI, perhaps? I don't know if any firmwares actually
>> do this).
>=20
> Right. That's what happens already with the current pile.
>=20
>> So all this seems to put UINV into the "independent" category of
>> feature along with LBR.  And the 512-byte wastes from extra copies of
>> the legacy area and the loss of the XMODIFIED optimization will just
>> be collateral damage.
>=20
> So we'd end up with two XSAVES on context switch. We can simply do:
>=20
>        XSAVES();
>        fpu.state.xtsate.uintr.uinv =3D 0;

Could work. As long as UINV is armed, RR can change at any time (maybe just w=
hen IF=3D1? The manual is unclear).  But the first XSAVES disarms UINV, so m=
aybe this won=E2=80=99t confuse any callers.

>=20
> which allows to do as many XRSTORS in a row as we want. Only the final
> one on the way to user space will have to restore the real vector if the
> register state is not valid:
>=20
>       if (fpu_state_valid()) {
>            if (needs_uinv(current)
>               wrmsrl(UINV, vector);
>       } else {
>            if (needs_uinv(current)
>               fpu.state.xtsate.uintr.uinv =3D vector;
>            XRSTORS();
>       }
>=20
> Hmm?

I like it better than anything else I=E2=80=99ve seen.

>=20
> Thanks,
>=20
>        tglx=20
