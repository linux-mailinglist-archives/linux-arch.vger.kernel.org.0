Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7B1217C85
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jul 2020 03:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgGHBXK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jul 2020 21:23:10 -0400
Received: from foss.arm.com ([217.140.110.172]:59690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbgGHBXK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Jul 2020 21:23:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F1701FB;
        Tue,  7 Jul 2020 18:23:09 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D83B83F718;
        Tue,  7 Jul 2020 18:23:06 -0700 (PDT)
Subject: Re: [PATCH -next] Documentation/vm: fix tables in
 arch_pgtable_helpers
To:     Randy Dunlap <rdunlap@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <02ee60d0-e836-2237-4881-5c57ccac5551@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b9dfad77-8dee-4628-a9f3-43417568a0e5@arm.com>
Date:   Wed, 8 Jul 2020 06:52:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <02ee60d0-e836-2237-4881-5c57ccac5551@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 07/08/2020 06:37 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Make the tables be presented as tables in the generated output files
> (the line drawing did not present well).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  Documentation/vm/arch_pgtable_helpers.rst |  333 ++++++--------------
>  1 file changed, 116 insertions(+), 217 deletions(-)

Do you have a git URL some where to see these new output ? This
documentation is also useful when reading from a terminal where
these manual line drawing tables make sense.
