Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CD06413AE
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiLCCpa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiLCCp3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:45:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1CAA7AAD
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:45:28 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so9948838pjs.4
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWPbe7F7je25IvRp5tTWOWJxp/+2tKAEeYAMwrnHX3I=;
        b=OeqW2Nqj7v6wmWLAIuXU1QUcVafcdaqj28BksV47DQWLlWr4PTt1J4XCOQ454A4bFG
         TnB8dB810gc+e0jB5mOvXEhdj0JUTzkaMInzsFyeboMhjJ0cJ/qcl4J0adKp4oQMBl4j
         MniyfBPyATrxtCbDMP4lUaT8Hxyueoc1+DkWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWPbe7F7je25IvRp5tTWOWJxp/+2tKAEeYAMwrnHX3I=;
        b=r3kIKMLYFrEfB3zlgLHxPOy8rgGB25ADO6yP2jENKujGfXtmFP5ahKj8j1YPiRB18m
         jzHfPoV2FKTnz6Ed3WhkEToM10xPIDoNgDO1TZ5jko3GepsRqs/MDKxUukIDsfTdnLyU
         X1JNq+jI19yKIvL98K0SAlgtPXV1dIQy2/ZFMRup00xEMBUqx1RzENer5OFYyW5WvlPM
         qlkOhTDDe2w9cw8KU3wsmn+XjDit1Kpdz+ju/k5YrhWWQeW6mDq5vIa2JZ0ZIZ9UaNaN
         v2unMreejACxkRuVlPh+Pd189b3o/EOSHmMjlBGuCXUuyNlqjm6wOojJlFL59Zn0yeEz
         32BA==
X-Gm-Message-State: ANoB5plOpCseRPEPVrVzgniMYeg1GrvwAHy6bGWR8JyHhyfbq8xgELZv
        g6buPYLyV1i6gmjYUNOZjntOGg==
X-Google-Smtp-Source: AA0mqf7RDtFvAEvWe64RZK8PfilyOJ4dzXrwN63EljeiYQe8nUiUTNgCvUVRzgsKQzmQWH/Zqqmtvg==
X-Received: by 2002:a17:902:ec8d:b0:188:59d2:33e with SMTP id x13-20020a170902ec8d00b0018859d2033emr53749396plg.142.1670035527895;
        Fri, 02 Dec 2022 18:45:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b00183c67844aesm6288151plg.22.2022.12.02.18.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:45:27 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:45:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v4 28/39] x86/shstk: Introduce routines modifying shstk
Message-ID: <202212021845.4A92DA95@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-29-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-29-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:55PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Shadow stacks are normally written to via CALL/RET or specific CET
> instuctions like RSTORSSP/SAVEPREVSSP. However during some Linux
> operations the kernel will need to write to directly using the ring-0 only
> WRUSS instruction.
> 
> A shadow stack restore token marks a restore point of the shadow stack, and
> the address in a token must point directly above the token, which is within
> the same shadow stack. This is distinctively different from other pointers
> on the shadow stack, since those pointers point to executable code area.
> 
> Introduce token setup and verify routines. Also introduce WRUSS, which is
> a kernel-mode instruction but writes directly to user shadow stack.
> 
> In future patches that enable shadow stack to work with signals, the kernel
> will need something to denote the point in the stack where sigreturn may be
> called. This will prevent attackers calling sigreturn at arbitrary places
> in the stack, in order to help prevent SROP attacks.
> 
> To do this, something that can only be written by the kernel needs to be
> placed on the shadow stack. This can be accomplished by setting bit 63 in
> the frame written to the shadow stack. Userspace return addresses can't
> have this bit set as it is in the kernel range. It is also can't be a
> valid restore token.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
