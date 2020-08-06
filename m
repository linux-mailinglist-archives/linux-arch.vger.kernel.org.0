Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A11923D96D
	for <lists+linux-arch@lfdr.de>; Thu,  6 Aug 2020 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgHFKtv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Aug 2020 06:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbgHFKpH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Aug 2020 06:45:07 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987A9C0617A0
        for <linux-arch@vger.kernel.org>; Thu,  6 Aug 2020 03:27:51 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w25so15704681ljo.12
        for <linux-arch@vger.kernel.org>; Thu, 06 Aug 2020 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kMBgMZhsaHkiYpNXe6mnulxBmErGl6mZVT718X/hP1s=;
        b=q44JM/MhPtGS1X8CEtdPT8jY1IsznRmL/EUJCRVKZ0SQjpJuKmiF3MRSg0V201k6/0
         7wdleRwGXgcpS6GBcJQn3aN4+K1pHDGZuvFRDvTF9APAIhXb+a2xl9Jp+eur4UHwQKOG
         a+RLO7aCLHiHjNUkqDHv3KHpAByqNpYKygFYVYfjG2rDRNZ1boVJjHid9G6QxHXMRDHj
         lxu6G5SWy3EMKBtlkZJxRZeLycn9DXYVVNUnw64xSNl8FhKmMBKmB/5GaDUrg6bknGVy
         69EcKcUZE3qqrUPWzoTffaHacemMJWCOZb/G6QEBjYa8rAKMuVSkNGFwC876gdtvvS/j
         Xp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kMBgMZhsaHkiYpNXe6mnulxBmErGl6mZVT718X/hP1s=;
        b=LwXUHhQqRuipmZqcQ4ir+7EhCL5MRVvE3zH4cs9OzhcqAu9Op0bkmoJR1St6QYRXom
         l1ulGZo2B7SFSpHAr49Irx9H3/OI2m4a0EqI0K13W3pK+2kwz25sy/PeEa0/dH+6ou8k
         FC3GBpG/7EcLTmsSIN/JFl0/eoy/v+tqg/LBoYkmj9aznD6kucoZf+mcGmr2nJO3Eaug
         LQx1/2U2084pUDELYEZVaRwANJUY/QercVAqeX7ABs74+tFDsWlpCnovcdDWFLUpVyYY
         s9nWbjK7q+g/vW4OyIDo+W21DYlZVUfXourL6fqqs+Upy2RJmlK1mA7lrRzTupk00xVA
         AXrA==
X-Gm-Message-State: AOAM533j9x+KlKkYQOOWBNMTDnWEmBpEtO7VNUYE226Fb2HLn8pp1HQG
        n9Q92uciZmzHyXigQKHN5E9qcQ==
X-Google-Smtp-Source: ABdhPJwKs0kOBphzk4nhXY72GuBZVVKvwfIRMs8kMWmC7io4Zo82tk1RHZ72Ob2Qcz50sTYcK1DvmA==
X-Received: by 2002:a05:651c:201b:: with SMTP id s27mr3653296ljo.468.1596709669841;
        Thu, 06 Aug 2020 03:27:49 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h18sm2208204ljk.7.2020.08.06.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 03:27:49 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 80A47102E1B; Thu,  6 Aug 2020 13:27:57 +0300 (+03)
Date:   Thu, 6 Aug 2020 13:27:57 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v3 3/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200806102757.7vobcaewdukr2xdl@box>
References: <20200804095035.18778-1-rppt@kernel.org>
 <20200804095035.18778-4-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804095035.18778-4-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 04, 2020 at 12:50:32PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Introduce "memfd_secret" system call with the ability to create memory
> areas visible only in the context of the owning process and not mapped not
> only to other processes but in the kernel page tables as well.
> 
> The user will create a file descriptor using the memfd_secret() system call
> where flags supplied as a parameter to this system call will define the
> desired protection mode for the memory associated with that file
> descriptor. Currently there are two protection modes:
> 
> * exclusive - the memory area is unmapped from the kernel direct map and it
>               is present only in the page tables of the owning mm.
> * uncached  - the memory area is present only in the page tables of the
>               owning mm and it is mapped there as uncached.

I'm not sure why flag for exclusive mode is needed. It has to be default.
And if you want uncached on top of that set the flag.
What am I missing?

-- 
 Kirill A. Shutemov
