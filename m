Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB051308DFD
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 21:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhA2UCO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 15:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbhA2T7a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 14:59:30 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D81C061574
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 11:58:24 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r38so7368429pgk.13
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 11:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=aPmRknrUXoM+y6mtZ5BJIoZ2z2YX2kZHPwEWyf5g8oc=;
        b=aGp6lfHXNFiIoLGHImiNQDdm/k9ZVdbPXLHXzyLRrq20nvxq0i4U/eIYXg1+udihlc
         1AJqRM191iNRasbNF0tJetz0cEnR6xX+JGEI4M4ZO4XFEtLTMPoRtQONA1kUCPqT3bq7
         VGh9DfPFhQ/FBR9e2uZGqQMlH6sdmeHA5lro8JgNwX+lWEwkja8X7ODQFTkrmK4b0Psn
         b6lSUJdAEwMkPKKlN8TF7msXr7KnUfDh4Q/4WDY1HGTZxFABmtNNmtvbpT/7yvwN64pD
         tOji7YJ+jm0mTT/zBekdF3XUHPrmMxFjZZrpxvyRA7cROMwzT1an3fAHQwL4nv5O03Dn
         xOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=aPmRknrUXoM+y6mtZ5BJIoZ2z2YX2kZHPwEWyf5g8oc=;
        b=cb4FEeHF5WsrUzubps06BPRRT4kl03at/9433RffEogEVw3qnd68ucb1il4B1L29fc
         t+cgZ6ygJ6oa2UE6IWHcHufPZzPUFhks7c9xPyltjLxGo9zJSKG5z8F45QI8twe0WlHU
         VPhxMl/ywLgqzsTYzNuViaEvzyBpnIOCzXA3SYNunSveT0FLWInMlHxIYdmwOL7ThHkr
         vuCPNlsDWz5bNG3SlDqNKBRl20bho0xT36xf8AVczEMYzPTZsyG1R2LTdxq9Z3eZ1/8s
         QfonhuHR355sgBqvmTDAtuA7hBZZKkItqkUmUrPFbdz5QToPCRPjLw7D3pDfPjCxd8UJ
         OQTw==
X-Gm-Message-State: AOAM5339ZPVqqcjYD2U7CzryOQsD7xCFi5U72NENs8POqvU/8sZTqQWs
        kSOPmnb2rW2cPLJmo0MapIjqBQ==
X-Google-Smtp-Source: ABdhPJyVSSMtq6GrB08WQhwRVajO1mCXK195f1+mqR1Nl8ENdGTgc77vzrwNYHLhtryRg06DbVCv0Q==
X-Received: by 2002:a63:5116:: with SMTP id f22mr6162045pgb.162.1611950304487;
        Fri, 29 Jan 2021 11:58:24 -0800 (PST)
Received: from ?IPv6:2600:1010:b04b:3f76:e5b1:55a0:5bce:dce3? ([2600:1010:b04b:3f76:e5b1:55a0:5bce:dce3])
        by smtp.gmail.com with ESMTPSA id y10sm9771144pff.197.2021.01.29.11.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 11:58:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v18 02/25] x86/cet/shstk: Add Kconfig option for user-mode control-flow protection
Date:   Fri, 29 Jan 2021 11:58:21 -0800
Message-Id: <86F8CE62-A94B-46BD-9A29-DBE1CC14AA83@amacapital.net>
References: <40a5a9b5-9c83-473d-5f62-a16ecde50f2a@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
In-Reply-To: <40a5a9b5-9c83-473d-5f62-a16ecde50f2a@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jan 29, 2021, at 11:42 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 1/27/21 1:25 PM, Yu-cheng Yu wrote:
>> +    help
>> +      Control-flow protection is a hardware security hardening feature
>> +      that detects function-return address or jump target changes by
>> +      malicious code.
>=20
> It's not really one feature.  I also think it's not worth talking about
> shadow stacks or indirect branch tracking in *here*.  Leave that for
> Documentation/.
>=20
> Just say:
>=20
>    Control-flow protection is a set of hardware features which
>    place additional restrictions on indirect branches.  These help
>    mitigate ROP attacks.
>=20
> ... and add more in the IBT patches.
>=20
>> Applications must be enabled to use it, and old
>> +      userspace does not get protection "for free".
>> +      Support for this feature is present on processors released in
>> +      2020 or later.  Enabling this feature increases kernel text size
>> +      by 3.7 KB.
>=20
> Did any CPUs ever get released that have this?  If so, name them.  If
> not, time to change this to 2021, I think.

Zen 3 :)=
