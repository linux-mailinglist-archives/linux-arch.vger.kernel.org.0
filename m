Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D128C17153E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 11:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgB0Kmx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 05:42:53 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:49496 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgB0Kmx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 05:42:53 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Sq4p6C5jz9tyhj;
        Thu, 27 Feb 2020 11:42:50 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=S2lr/JhY; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id RBUcz2GDDss6; Thu, 27 Feb 2020 11:42:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Sq4p546Vz9tyhl;
        Thu, 27 Feb 2020 11:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582800170; bh=5jVgSlMtkWu6tY2vWvxiJHRV/VXhxhn9Ff1N2fIt2UU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S2lr/JhYZ+BGylLoddvoIQ9iQhySwoByCGIjiV2jJ0PeIWGuHFGwJKoDCDBlMX134
         i5DDDsfMVW33gpJWXfhaNVZkRAjliFDf2imHM3gIFbd6vhCt20XFgykuEBdbkrcViD
         lQGvXfjqGVwxK9iazQgdwBp51saPHe4oEmbNBr5A=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BCB398B875;
        Thu, 27 Feb 2020 11:42:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FEU3XPlFNEyZ; Thu, 27 Feb 2020 11:42:51 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 20C4A8B879;
        Thu, 27 Feb 2020 11:42:48 +0100 (CET)
Subject: Re: [PATCH] mm/debug: Add tests validating arch page table helpers
 for core features
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-snps-arc@lists.infradead.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
References: <1582799637-11786-1-git-send-email-anshuman.khandual@arm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <51421bb3-9075-d7e9-1750-0553a1ebe64a@c-s.fr>
Date:   Thu, 27 Feb 2020 11:42:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1582799637-11786-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 27/02/2020 à 11:33, Anshuman Khandual a écrit :
> This adds new tests validating arch page table helpers for these following
> core memory features. These tests create and test specific mapping types at
> various page table levels.
> 
> * SPECIAL mapping
> * PROTNONE mapping
> * DEVMAP mapping
> * SOFTDIRTY mapping
> * SWAP mapping
> * MIGRATION mapping
> * HUGETLB mapping

For testing HUGETLB mappings, you also have to include tests of hugepd 
functions/helpers. Not all archictures have hugepage size which matches 
with page tables levels (e.g. powerpc). Those architectures use hugepd_t.

Christophe
