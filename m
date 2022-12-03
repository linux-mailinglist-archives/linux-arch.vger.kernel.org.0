Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FAF64135B
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 03:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbiLCC2R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 21:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbiLCC2N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 21:28:13 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1B759FD5
        for <linux-arch@vger.kernel.org>; Fri,  2 Dec 2022 18:28:11 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 140so6533425pfz.6
        for <linux-arch@vger.kernel.org>; Fri, 02 Dec 2022 18:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOsmhWzvTaGod4c98WIAwoN6RgdbrhOpBfnKGq6TCqg=;
        b=KvAsfhCwVbLiHtggx4tLU+VgpymrMDHEzjPfhgXtmVu/ofbJX5AhlXNCHmaTYn5KAp
         Py5x3/L/SY0cp4KjKMqFdj0TT4KzaX71tq6XCmOX/+8/RjaXBtgpB9reg7zfFfOGC01V
         ZHRTs9UAP5P1M8HT39RFsB1QQ8YFZtMDHhVdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOsmhWzvTaGod4c98WIAwoN6RgdbrhOpBfnKGq6TCqg=;
        b=eeQUcpxD7WaNFoIkx/dVuVIm1jRNJI/pvcPFe/qTCaCQk2wMBsJnuKMvunqx/BloK/
         AlP0jyLOLM2TBz8hYDCV9aFf0ZD6bEIoHEYfV/uBEJfbciTJc1BYxOGkoReFaE+77yHi
         5fWTbZxzZc5YLDxCv9/i8UuR9SitOsRMkWjCAxH++6Iel7J2gHvoxdqQPAymizJQ2TT6
         zbJbW5oQN5OYTX4Am0bfDDv97J0nD434Zeg31AtoDoG+Wa2Q84qExdG2WAwZ2+M2OXWv
         xg3kCNSR1z0xKIuc/9cteS/a1RJTxBmdOSryatUCHJhaNfIPkeR9M4Ixr6/hxV9nP4Qi
         izhw==
X-Gm-Message-State: ANoB5pnqkn7e3FTCDqn4ZDjbakU6NXiBcX+fIRkvMzNjCvCWjmBW8CrL
        mU/pJsMMYqWzOXlf7Ns9/DEFxQ==
X-Google-Smtp-Source: AA0mqf5LGiNqlxi+OSZapMhWipQg4aQbiacQEOzN4PxP65c2T9P8s/SelBujWUq07q05VtM4ESiCWQ==
X-Received: by 2002:a63:ce0e:0:b0:457:dced:8ba9 with SMTP id y14-20020a63ce0e000000b00457dced8ba9mr51658398pgf.221.1670034490505;
        Fri, 02 Dec 2022 18:28:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w4-20020a634744000000b004786c63c21esm3602572pgk.42.2022.12.02.18.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:28:09 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:28:08 -0800
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
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v4 07/39] x86: Add user control-protection fault handler
Message-ID: <202212021827.03F637C9C9@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-8-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-8-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:34PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> A control-protection fault is triggered when a control-flow transfer
> attempt violates Shadow Stack or Indirect Branch Tracking constraints.
> For example, the return address for a RET instruction differs from the copy
> on the shadow stack.
> 
> There already exists a control-protection fault handler for handling kernel
> IBT. Refactor this fault handler into sparate user and kernel handlers,
> like the page fault handler. Add a control-protection handler for usermode.
> 
> Keep the same behavior for the kernel side of the fault handler, except for
> converting a BUG to a WARN in the case of a #CP happening when
> !cpu_feature_enabled(). This unifies the behavior with the new shadow stack
> code, and also prevents the kernel from crashing under this situation which
> is potentially recoverable.
> 
> The control-protection fault handler works in a similar way as the general
> protection fault handler. It provides the si_code SEGV_CPERR to the signal
> handler.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

This looks nice cleaner to me. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
