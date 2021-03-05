Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC8B32EFB8
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 17:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhCEQKG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 11:10:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:13875 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhCEPmD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 10:42:03 -0500
IronPort-SDR: h+hvCEIS5InekBwwtEUf9sfVt7rSC2alLX0EG+1u7b2u2aHLYP4P8UX+Y+nudA2mZu0BAakgFI
 PK0JbOFg5Cyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9914"; a="185262821"
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; 
   d="scan'208";a="185262821"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 07:41:59 -0800
IronPort-SDR: 2yGt/3QzPDUR/vFTYp9fAGjodIvlP+jFUdJ2O2BL4z7B2UaB1DFgd+rO17jcCnz0etf70GBbhR
 FpRkAYw2GQkw==
X-IronPort-AV: E=Sophos;i="5.81,225,1610438400"; 
   d="scan'208";a="408343831"
Received: from luetzenk-mobl.ger.corp.intel.com (HELO btopel-mobl.ger.intel.com) ([10.249.43.131])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 07:41:53 -0800
Subject: Re: [PATCH] tools/memory-model: Fix smp_mb__after_spinlock() spelling
To:     Alan Stern <stern@rowland.harvard.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
References: <20210305102823.415900-1-bjorn.topel@gmail.com>
 <20210305153655.GC38200@rowland.harvard.edu>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <e90fee12-a29e-cddb-5db3-24d92d4e03f8@intel.com>
Date:   Fri, 5 Mar 2021 16:41:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305153655.GC38200@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021-03-05 16:36, Alan Stern wrote:
> On Fri, Mar 05, 2021 at 11:28:23AM +0100, Björn Töpel wrote:
>> From: Björn Töpel <bjorn.topel@intel.com>
>>
>> A misspelled invokation of git-grep, revealed that
> -------------------^
> 
> Smetimes my brain is a little slow...  Do you confirm that this is a
> joke?
>

I wish, Alan. I wish.

Looks like I can only spel function names correctly.


Have a nice weekend!
Björn


> Alan
> 
