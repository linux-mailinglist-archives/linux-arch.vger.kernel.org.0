Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2314C26635D
	for <lists+linux-arch@lfdr.de>; Fri, 11 Sep 2020 18:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgIKPco (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 11:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgIKPaa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Sep 2020 11:30:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FEC21D47;
        Fri, 11 Sep 2020 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599832945;
        bh=ugt57UudOowWxtW+wZwTzUmbFy/FfUpWgsziWteq/yQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iyMk4uzpjZpEepjpkfSV+Fi7J2/MfhDLNcdKUrA/C32d5IjiQL4/4bGPB0/+2NVUl
         bBJg0nHnRrt6D6mXYZgu3cQ77PmKM8/BjP/7Kqlm5qjyIKRXDuEzUSUO8NebUNVoLA
         SazSpnykjUAV4ZS+ytntTdBOjbPleH2bVha2mTyM=
Date:   Fri, 11 Sep 2020 15:02:19 +0100
From:   Will Deacon <will@kernel.org>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@kernel.org, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] docs/memory-barriers.txt: Fix a typo in CPU MEMORY
 BARRIERS section
Message-ID: <20200911140218.GB19961@willie-the-truck>
References: <20200909065340.118264-1-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909065340.118264-1-foxhlchen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 09, 2020 at 02:53:40PM +0800, Fox Chen wrote:
> Commit 39323c6 smp_mb__{before,after}_atomic(): update Documentation
> has a typo in CPU MEORY BARRIERS section:
> "RMW functions that do not imply are memory barrier are ..." should be
> "RMW functions that do not imply a memory barrier are ...".
> 
> This patch fixes this typo.
> 
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  Documentation/memory-barriers.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 96186332e5f4..20b8a7b30320 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1870,7 +1870,7 @@ There are some more advanced barrier functions:
>  
>       These are for use with atomic RMW functions that do not imply memory
>       barriers, but where the code needs a memory barrier. Examples for atomic
> -     RMW functions that do not imply are memory barrier are e.g. add,
> +     RMW functions that do not imply a memory barrier are e.g. add,
>       subtract, (failed) conditional operations, _relaxed functions,
>       but not atomic_read or atomic_set. A common example where a memory
>       barrier may be required is when atomic ops are used for reference

The document remains unreadable, but this is still worth fixing!

Acked-by: Will Deacon <will@kernel.org>

Will
