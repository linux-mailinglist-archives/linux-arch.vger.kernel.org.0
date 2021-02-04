Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5C730FE0E
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbhBDUVC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 15:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239980AbhBDUU7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 15:20:59 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7784C061222
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 12:20:19 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x9so2368520plb.5
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 12:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F9VJiSBsSJrC2jYFpinGxml1C+FEA2FI359p7GFWxRk=;
        b=c/5NkgLk9f8BEYqE56ET8+WzEVofqlfPRO+MbMbE//bUeWJRI02oNDJzpV0SLJhIc5
         6D9RH/prXQsmSQGf9ZgZnJtulSPKZgpfDnA7ktC3nrpRtv+lWuTHekSo3NZ/Nie2Hyb3
         SJOnCJ5RfkMbhhOvVcpnRaN4WpUpxHytY/BYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F9VJiSBsSJrC2jYFpinGxml1C+FEA2FI359p7GFWxRk=;
        b=XhL6IozLGQhz8PQoXhQOuSY01rg1tLqeAaJa3ytX8fppPL1pVY9MrhgUekKc7gWOLZ
         wz1FfGsZcOkExWjPK91jJ637K5FGuKUb7XroS63Va4ZDFgM+8qYqnDkR3yaNYWv4rf8z
         IEsSdwcTZ94bGTDivNGxgYkRna44K0eihExyv6/wJqTljOPqzDVse30Fgfb9vWNV03zw
         qhLZ7WrT8arCi3U1HD/EivOdVS+9zpZe6iDYEUwlDBr6lokfojQsbQaTzfmGm5HIu5ic
         yMJnowSM6pfGaOVxEPXT0lRezyeOn//AlHVBVZZ5UIXKHII1zBMN56sHCzCRVZmyTD5O
         +oXw==
X-Gm-Message-State: AOAM530AKoOkO6m8OIlGnf1kopHyQSFpipcBzlzs6dZUFRBHjeqEN7e5
        rTtz0B4akaCGtANLepJe/9vLNA==
X-Google-Smtp-Source: ABdhPJzAoT/duN3/3cQeFbJsfsFNnEoob6e0vNs7paRZBNrsjtPhY9hV5JE0VMUySldPrJ1O+2IAhg==
X-Received: by 2002:a17:902:a517:b029:de:79a7:48d9 with SMTP id s23-20020a170902a517b02900de79a748d9mr794632plq.45.1612470019288;
        Thu, 04 Feb 2021 12:20:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u12sm7319901pgi.91.2021.02.04.12.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:20:18 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:20:17 -0800
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
Subject: Re: [PATCH v19 10/25] x86/mm: Update pte_modify for _PAGE_COW
Message-ID: <202102041220.17A5BFD5BB@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-11-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-11-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:32PM -0800, Yu-cheng Yu wrote:
> The read-only and Dirty PTE has been used to indicate copy-on-write pages.
> However, newer x86 processors also regard a read-only and Dirty PTE as a
> shadow stack page.  In order to separate the two, the software-defined
> _PAGE_COW is created to replace _PAGE_DIRTY for the copy-on-write case, and
> pte_*() are updated.
> 
> Pte_modify() changes a PTE to 'newprot', but it doesn't use the pte_*().
> Introduce fixup_dirty_pte(), which sets a dirty PTE, based on _PAGE_RW,
> to either _PAGE_DIRTY or _PAGE_COW.
> 
> Apply the same changes to pmd_modify().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
