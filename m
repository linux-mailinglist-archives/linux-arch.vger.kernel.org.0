Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5BB30FDDB
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbhBDTyQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 14:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbhBDTwC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 14:52:02 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6732AC061222
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 11:50:23 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d26so1535319pfn.5
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 11:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OCBNpOzMc8CAOBfAgX/jLAhp/SQecCvHp/iShWPRCZQ=;
        b=UzKHJoHstJUn1+EShPvxaJaqClm9LA26kdmfw9zDnAdyzrAY6CqEgnlW45I0CJthX4
         DDUOM1Ntq+iwMd+/8nEiBF24eu4IJc41zF9EcSwZWNb05Nf6D9yLHf7Eb2Pyi63otlod
         3RwHieM8ryVd+jiq/SMM936MFgxNwHfq3RlWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OCBNpOzMc8CAOBfAgX/jLAhp/SQecCvHp/iShWPRCZQ=;
        b=lnIUVacyP0KV11aUFCDEMgMciLDGLPPJLu4Rbk+K9bFlMJCWzegsO2KVhOtkMvSdbP
         P+asJ0YB4xHGKIyakviKqkEaL9pI1m4DRwgMnaVdraZ45tPnGlaHFkq8U9lCYItdO4xy
         gve4enEQzSYNHjpZXx+ijyhEnWcXSguGN6IhaEZO2B6BBWFtIF/OIfmNvuHRMN0XnAxb
         bppvxurGXxbji1tporkgLpKRoVtyMPuJPhdIoDogtx41mAsBzm0sgXk6/2xe2AYvfF/b
         q84qzA3qgN+eCu5i3u2NxR71M8eNCb1LIMFAbZm0znQcEnYzMk4GV/NM6J+ca99yI/+2
         uS9w==
X-Gm-Message-State: AOAM530kjg3B5E27IfCIRz1c6EjVxEJFH0AOXf2rR0AyuZIlY9fCYM1i
        GFrj9BsDdW7SUH0Ec9g1L9U+pA==
X-Google-Smtp-Source: ABdhPJwi3qGotMQdzbjuJor6PdBiBP52TZP1QRJ9SqH5R+oUXMnOHkiFLvDUNqFp4od9u/7BXFE1Fw==
X-Received: by 2002:a63:794a:: with SMTP id u71mr592348pgc.91.1612468222994;
        Thu, 04 Feb 2021 11:50:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r7sm6299408pfc.26.2021.02.04.11.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:50:22 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:50:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
Subject: Re: [PATCH v19 5/7] x86/cet/ibt: Update arch_prctl functions for
 Indirect Branch Tracking
Message-ID: <202102041150.6186296C3@keescook>
References: <20210203225902.479-1-yu-cheng.yu@intel.com>
 <20210203225902.479-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225902.479-6-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:59:00PM -0800, Yu-cheng Yu wrote:
> From: "H.J. Lu" <hjl.tools@gmail.com>
> 
> Update ARCH_X86_CET_STATUS and ARCH_X86_CET_DISABLE for Indirect Branch
> Tracking.
> 
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
