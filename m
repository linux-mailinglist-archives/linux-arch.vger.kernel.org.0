Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5F767487F
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 02:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjATBEE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 20:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjATBEE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 20:04:04 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D582A103D
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 17:04:02 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i65so2906045pfc.0
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 17:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RMyK8TWBy/rCRY+f/CELnWHAsbOxEp5tJ/kKh7SlGrE=;
        b=HNvX51O/DEprXKflx7pWqaGjLOmylpOJlGBu4RvAtyIGoWOf8U7lNla8R/lxB/pY7w
         6T9BXQ8lPsUoUa7unGyKu+xDkqDQjSGqhnaebMz/E+vQnvXwkiXITiJCSaQK4OMwelJd
         qDigrbkkGoU7L5umpJREXH5gQODW8jcOSvVTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMyK8TWBy/rCRY+f/CELnWHAsbOxEp5tJ/kKh7SlGrE=;
        b=qG2r8nd+n8JvCITuQWTQkozPyZ/HLx9gmWRAAIvTFtmLFedq5IJ5KQhwxydjaAH0uz
         1uv5c+Nlm4YG02+LXKe9stSRB04qQIOomVnAWMp85oB2b2O9W3Ssf88hkEAMgTSiKYTL
         VA9QZ+KJrt0h5hDini73t7hXy9xX7NiyMKbPJUl2HpHi2JNMOn28IQDD27J6zQN9d2E+
         Jg0cgNqpW0OFXoD0ZSapOm6b2hR98q6IKb6LmETJaApulc78fV2863fLppPMzJOyVS+y
         jkovgGxFqbp3teh08ViNm+dl5Nu8bmCil4fApB8d3LQnybUFwKXfnFoEHE2h55+GzlZp
         kcgg==
X-Gm-Message-State: AFqh2koPq2JI8dxJjBtKAZS4LJttxufVKh5N3LEz5jgnRfQs4gvntLd2
        WwQHwEu8IdqtXbmqgilLPqCXqA==
X-Google-Smtp-Source: AMrXdXtTKI2kkFnGFw4R9p4eZUplQk2pOiwojsYgvuPj7O8XWjxV8VJBE5XmixgDIcb3rYne6nRs3A==
X-Received: by 2002:a05:6a00:bc8:b0:58d:97cd:b65a with SMTP id x8-20020a056a000bc800b0058d97cdb65amr13351335pfu.26.1674176642023;
        Thu, 19 Jan 2023 17:04:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 134-20020a62148c000000b0056bc30e618dsm24694079pfu.38.2023.01.19.17.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:04:01 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:04:00 -0800
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Subject: Re: [PATCH v5 26/39] x86: Introduce userspace API for shadow stack
Message-ID: <202301191703.9E24A4E52@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-27-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-27-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:23:04PM -0800, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Add three new arch_prctl() handles:
> 
>  - ARCH_SHSTK_ENABLE/DISABLE enables or disables the specified
>    feature. Returns 0 on success or an error.
> 
>  - ARCH_SHSTK_LOCK prevents future disabling or enabling of the
>    specified feature. Returns 0 on success or an error
> 
> The features are handled per-thread and inherited over fork(2)/clone(2),
> but reset on exec().
> 
> This is preparation patch. It does not implement any features.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
