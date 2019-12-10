Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D42C118B3A
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2019 15:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfLJOji (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Dec 2019 09:39:38 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:48137 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfLJOji (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Dec 2019 09:39:38 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47XN4R2jvMz9txPV;
        Tue, 10 Dec 2019 15:39:35 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=S5kJVxPB; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id h_8fAE0U-HoN; Tue, 10 Dec 2019 15:39:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47XN4R1Whkz9txPQ;
        Tue, 10 Dec 2019 15:39:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575988775; bh=gC07UrkwsOByoVoBIV4uyW1SIFHfck0w0oYmnN2eVmc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=S5kJVxPBDtEJof7P7KiznADxbNG3gE1jXaxpcR3MKMReOTnvMUIuCOPU2EwO2JYvz
         bQF+6k36pGkxUSHvMr2woVfbXc1TrlcRFqStmczYl+Zel3SHLk7Imx+672RESlTwWE
         TGGY3rLrhsFplKCs29s3aOxdlXrG4Jy0gYxaqwLk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A165C8B815;
        Tue, 10 Dec 2019 15:39:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Hn7oLwJSlDri; Tue, 10 Dec 2019 15:39:36 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 96E4F8B754;
        Tue, 10 Dec 2019 15:39:35 +0100 (CET)
Subject: Re: [PATCH v2 2/4] kasan: use MAX_PTRS_PER_* for early shadow
To:     Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com
References: <20191210044714.27265-1-dja@axtens.net>
 <20191210044714.27265-3-dja@axtens.net>
 <a31459ee-2019-2f7b-0dc1-235374579508@gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5d1ec6e3-777e-9f23-ea8f-50361a29302f@c-s.fr>
Date:   Tue, 10 Dec 2019 15:39:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <a31459ee-2019-2f7b-0dc1-235374579508@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 10/12/2019 à 10:36, Balbir Singh a écrit :
> 
> 
> On 10/12/19 3:47 pm, Daniel Axtens wrote:
>> This helps with powerpc support, and should have no effect on
>> anything else.
>>
>> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> If you follow the recommendations by Christophe and I, you don't need this patch

I guess you mean Patch 1 (the one adding the const to all arches) is not 
needed. Of course this one (Patch 2) is needed as it is the one that 
changes kasan.h to use const table size instead of impossible variable 
table size.

And that would also fix the problem reported by the kbuild test robot.

Christophe
