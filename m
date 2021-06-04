Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB89539BDFE
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 19:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhFDRGs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 13:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhFDRGs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 13:06:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94D00613F8;
        Fri,  4 Jun 2021 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622826301;
        bh=+lTqYiNuonGH3BQ6fCG8evBzKzm2s1oLT3TFmNDDrNg=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=rgFcUP+TeNimMfYqYZ7tgrpJf2TcbGvVtpu2LtAsi6flEd3qrFmpnZpjp5kHN+uYu
         P92ZKwWJa9uWkSo/aNMjGt7pTQcO3j/VmHYBB8eF79zJsTdJEqlQ4QCnaAQTdqHaOu
         iYHSWL/LcCcwOU/6wHNL0cMLR/bA8fUE/mzOIDyg4VcldkQmlc5gSjnB1yrH3d/iAe
         bHVHmAlEG+mpN2wP3sazG79vHWhb38/mEVSXPiJMBzQ5vsVdP08Bl/2+G8y/vSPrnm
         yZ99DVFQOxxjQSr3SX3/ONVXdb6frQbv72p8iU9vemLuZQjXpvUcORzdnBOLC9sxti
         x2sovuO4tQqcg==
Subject: Re: [PATCH v3 0/4] shoot lazy tlbs
From:   Andy Lutomirski <luto@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
References: <20210601062303.3932513-1-npiggin@gmail.com>
 <603ffd67-3638-4c47-8067-c1bdfdf65f1b@kernel.org>
Message-ID: <991660c3-c2bf-c303-a55c-7454f0cc45f7@kernel.org>
Date:   Fri, 4 Jun 2021 10:05:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <603ffd67-3638-4c47-8067-c1bdfdf65f1b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/4/21 9:54 AM, Andy Lutomirski wrote:
> On 5/31/21 11:22 PM, Nicholas Piggin wrote:
>> There haven't been objections to the series since last posting, this
>> is just a rebase and tidies up a few comments minor patch rearranging.
>>
> 
> I continue to object to having too many modes.  I like my more generic
> improvements better.  Let me try to find some time to email again.
> 

Specifically, this:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/mm

I, or someone, needs to dust off my membarrier series before any of
these kinds of changes get made.  The barrier situation in the scheduler
is too confusing otherwise.
