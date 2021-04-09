Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7571E35A1C5
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 17:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhDIPMo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 11:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbhDIPMl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2021 11:12:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1FC061761
        for <linux-arch@vger.kernel.org>; Fri,  9 Apr 2021 08:12:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id n138so10282647lfa.3
        for <linux-arch@vger.kernel.org>; Fri, 09 Apr 2021 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PDyMSJJvLIMFC1KbCjmLHB5PTIgl8fLhsjpA7s8Yb6Q=;
        b=WUE6Vxis/wkboifvaP4/0mKQH9ZqXTXg09FLow2NBClwREFinJQQ7Ym269+P2rGdYS
         H8OWs7F1iSt6G0pM1qTUlLYbVDnQPeqAXBmP92LWmtN69zpGrjqmOrTUUlRTZHR8pogT
         HSxBDs2fiYTfAa+HHPHzSFp+8beCoBX+rQifO+DG79+wglkVBUUlIFhyZuhQz4JHNwqk
         kPJS1NjJ+V/xdMmrwNrtSJB7PzFZN5PhPjT2q6jGA2WKNNSR3+/AURsA2gkd01+BcMhd
         0LXY1hEnpKIJdbbkNFmtfPJLm1ibRZPKLfbAtJRACzTh3QzzHpzbwLEb4YDGLWvW7amr
         s2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PDyMSJJvLIMFC1KbCjmLHB5PTIgl8fLhsjpA7s8Yb6Q=;
        b=cTMm/xIk/kRM7H51Pk47B3AVS2kwdGokXXy3ec1cAggqiFTkiB7P53uAeint00q3gh
         rDE6DmS6nht6xOmiVG2DJPbZ32l56XyjjB1eAfxsUjyKvuA3iE/Yl6PRNg5peH5hXAW2
         y6Jy58I4NfvaztwZsqjiMxkFivQikecr3lfcec2PhLY/J4S6A14t8I4MP56VIQS0qgFS
         rZp2wC9Kd9esyJBNUY1xJyDA93D8NfF4txwILbfPztEqO5XUN1wov9CInbe3MjBvtInE
         aUnBRw2kcyXFpYZuILHWlADdJeADJS3VEAN7uzb4GIMwddbt5sixrkZNl0dy6llPCf75
         QyqA==
X-Gm-Message-State: AOAM533+mq5bmW9LzxAlP4UV0BTOcZW5Tjf3rM3G9407ChZvhG3gDUxT
        SHYnZlXWq+CJKJF7WZIqGchQkQ==
X-Google-Smtp-Source: ABdhPJyAXO7XxweiGZ6jKD2WpLH/voQpq46hnsIJmUDXRxILxGzeLt3DBPtRLvbc6rthzzbO9px7xw==
X-Received: by 2002:a19:8c0a:: with SMTP id o10mr10600843lfd.175.1617981146160;
        Fri, 09 Apr 2021 08:12:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k18sm295287lfg.32.2021.04.09.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:12:25 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 05C1F102498; Fri,  9 Apr 2021 18:12:25 +0300 (+03)
Date:   Fri, 9 Apr 2021 18:12:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v24 14/30] x86/mm: Shadow Stack page fault error checking
Message-ID: <20210409151224.4tlklypbjpxcztpt@box.shutemov.name>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
 <20210401221104.31584-15-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401221104.31584-15-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 03:10:48PM -0700, Yu-cheng Yu wrote:
> Shadow stack accesses are those that are performed by the CPU where it
> expects to encounter a shadow stack mapping.  These accesses are performed
> implicitly by CALL/RET at the site of the shadow stack pointer.  These
> accesses are made explicitly by shadow stack management instructions like
> WRUSSQ.
> 
> Shadow stacks accesses to shadow-stack mapping can see faults in normal,
> valid operation just like regular accesses to regular mappings.  Shadow
> stacks need some of the same features like delayed allocation, swap and
> copy-on-write.
> 
> Shadow stack accesses can also result in errors, such as when a shadow
> stack overflows, or if a shadow stack access occurs to a non-shadow-stack
> mapping.
> 
> In handling a shadow stack page fault, verify it occurs within a shadow
> stack mapping.  It is always an error otherwise.  For valid shadow stack
> accesses, set FAULT_FLAG_WRITE to effect copy-on-write.  Because clearing
> _PAGE_DIRTY (vs. _PAGE_RW) is used to trigger the fault, shadow stack read
> fault and shadow stack write fault are not differentiated and both are
> handled as a write access.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
