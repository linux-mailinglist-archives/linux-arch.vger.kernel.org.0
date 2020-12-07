Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790DC2D173E
	for <lists+linux-arch@lfdr.de>; Mon,  7 Dec 2020 18:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLGRMY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Dec 2020 12:12:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:53267 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgLGRMY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Dec 2020 12:12:24 -0500
IronPort-SDR: 4WedHcgKxXjpH7+vFiWLGLLHvQtdjRbFfq/ff0xfQJvwW9Li6MPS6UOARPI//UxeLXMA1zEYnH
 N/H9t/zY/2OQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="153548837"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="153548837"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 09:11:41 -0800
IronPort-SDR: gU9g08IhB9QfbewodfyGKJL8AgbLIcT0M6qrKa1Z9jOWOFYTF2mvVDswR7gIVZyojuJ4MByAkr
 BeEAFFkD6PMQ==
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="436903607"
Received: from nkanakap-mobl1.amr.corp.intel.com (HELO [10.251.12.188]) ([10.251.12.188])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 09:11:39 -0800
Subject: Re: [PATCH v15 07/26] x86/mm: Remove _PAGE_DIRTY_HW from kernel RO
 pages
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Christoph Hellwig <hch@lst.de>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-8-yu-cheng.yu@intel.com>
 <20201207163632.GE20489@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <b2deed42-1252-62e1-0d82-beafb917d0ad@intel.com>
Date:   Mon, 7 Dec 2020 09:11:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201207163632.GE20489@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/7/2020 8:36 AM, Borislav Petkov wrote:
> On Tue, Nov 10, 2020 at 08:21:52AM -0800, Yu-cheng Yu wrote:
>> Kernel read-only PTEs are setup as _PAGE_DIRTY_HW.  Since these become
>> shadow stack PTEs, remove the dirty bit.
> 
> This commit message is laconic to say the least. You need to start
> explaining what you're doing because everytime I look at a patch of
> yours, I'm always grepping the SDM and looking forward in the patchset,
> trying to rhyme up what that is all about.
> 
> Like for this one. I had to fast-forward to the next patch where all
> that is explained. But this is not how review works - each patch's
> commit message needs to be understandable on its own because when
> they land upstream, they're not in a patchset like here. And review
> should be done in the order the patches are numbered - not by jumping
> back'n'forth.
> 
> So please think of the readers of your patches when writing those commit
> messages. Latter are *not* write-only and not unimportant.
> 
> And those readers haven't spent copious amounts of time on the
> technology so being more verbose and explaining things is a Good
> Thing(tm). Don't worry about explaining too much - better too much than
> too little.
> 
> And last but not least, having understandable and properly written
> commit messages increases the chances of your patches landing upstream
> considerably.
> 
> Thx.
> 

Thanks for your feedback.  I will improve the commit logs.

--
Yu-cheng
