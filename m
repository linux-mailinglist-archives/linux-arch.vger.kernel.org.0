Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEE7674819
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 01:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjATAiJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 19:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjATAiH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 19:38:07 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB64A1E7
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:38:06 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 127so2848701pfe.4
        for <linux-arch@vger.kernel.org>; Thu, 19 Jan 2023 16:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=opKKL6+fhG9H3ZnE4M3C01lHGZFgbl9xi06Tl9DFlxo=;
        b=lIedS74S3tmDvAWKf/pKIZQXH++46nIxIJzGdjRAjE9stYh7oH/dycv4f7V1NWEzz+
         vrpqcWM/ON5ywALOuqyE/K5lI6vcyOGLyyKtmi+HYl9pmLHQgMyOEmPmfOysBJfi7FtE
         sXfBhrRutvpoE0oPKPAf4SqWZz4MHXi555J34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opKKL6+fhG9H3ZnE4M3C01lHGZFgbl9xi06Tl9DFlxo=;
        b=jKTwCWrfV/0hDhiCRFS3i9fpUM1efnlm9H2s/zF53vZNVsaoel/gAz6OnMmkJmsJDw
         mo2ufG8ms1qsq8aVR5WOoa2H8AyVeaiv8PtOZeFxYH4xMeD5JRKZrGq5E9NZ0eVknW8L
         ZSTag2yVWrrRW/aqrNMn1OIfgJ/l88DP0ObNiBmzlIAFzn/PY1KX96lIW50K3+qEfYNx
         4AWBwOC1K8Z1g27x9cfQad+s70w6+36JXInair1tEKtn/knx+seftbXyIIO/+pwro430
         bWDGgLjh9iVY0G/p+LSJYG7rlam3XHzlenY7UL4bYcAg0RO5EdLKXEULP5mUNWEgqPg3
         5KuA==
X-Gm-Message-State: AFqh2kom0HEjBpxPOir+jPlHG8b0EgwBxLTibzdnhYFh+zjam1df3Wix
        Ftki+bDtDYSvdhCKT/v5jPfHhw==
X-Google-Smtp-Source: AMrXdXvDaBmAz43jKve14VMT5yvVg1paSSfHL+s3Uhw4JeU7qrDP9f2UUmfnfH3+wY9g4cAEosDVgw==
X-Received: by 2002:a62:aa0c:0:b0:58d:af0c:92f with SMTP id e12-20020a62aa0c000000b0058daf0c092fmr12442131pff.27.1674175085334;
        Thu, 19 Jan 2023 16:38:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z19-20020aa79593000000b00582388bd80csm24696882pfj.83.2023.01.19.16.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:38:04 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:38:03 -0800
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
Subject: Re: [PATCH v5 01/39] Documentation/x86: Add CET shadow stack
 description
Message-ID: <202301191638.E3E75FEC1D@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-2-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:22:39PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Introduce a new document on Control-flow Enforcement Technology (CET).
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
