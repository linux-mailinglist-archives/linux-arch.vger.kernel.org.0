Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70E81603AC
	for <lists+linux-arch@lfdr.de>; Sun, 16 Feb 2020 11:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgBPKqO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Feb 2020 05:46:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:16289 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgBPKqO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 16 Feb 2020 05:46:14 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48L3gh69Lpz9tyMB;
        Sun, 16 Feb 2020 11:46:08 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=RMQrDTHX; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0F5rpVhkSbpS; Sun, 16 Feb 2020 11:46:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48L3gh3dBjz9tyM9;
        Sun, 16 Feb 2020 11:46:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581849968; bh=puEVphfmlLbrWTO3mdDB17WkluHf49q+nkCLHU1WEPk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RMQrDTHXiSIvSNdSJIUAuTLTwTBfKbldAHrwtZjJ0BW+ZG7c0EUq537f7BNPK+LIN
         e+qzSqPhQUdW5m9f0ovUN5sc2R9fpgjJRx6JMSfOyIGDK3OikFgbqf4WNmfnjBWb14
         Yj8xq1+79SXISvpVp+Jg6Y8NZ4c+QrYGyIAwuT0U=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 63ADD8B784;
        Sun, 16 Feb 2020 11:46:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GYiIMEW0V5j7; Sun, 16 Feb 2020 11:46:10 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 992958B755;
        Sun, 16 Feb 2020 11:45:59 +0100 (CET)
Subject: Re: [PATCH v2 00/13] mm: remove __ARCH_HAS_5LEVEL_HACK
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guan Xuetao <gxt@pku.edu.cn>,
        James Morse <james.morse@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20200216081843.28670-1-rppt@kernel.org>
 <20200216082230.GV25745@shell.armlinux.org.uk>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d6691709-30ce-4d28-0b7b-34f1fa3b4e6f@c-s.fr>
Date:   Sun, 16 Feb 2020 11:45:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200216082230.GV25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 16/02/2020 à 09:22, Russell King - ARM Linux admin a écrit :
> On Sun, Feb 16, 2020 at 10:18:30AM +0200, Mike Rapoport wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>>
>> Hi,
>>
>> These patches convert several architectures to use page table folding and
>> remove __ARCH_HAS_5LEVEL_HACK along with include/asm-generic/5level-fixup.h.
>>
>> The changes are mostly about mechanical replacement of pgd accessors with p4d
>> ones and the addition of higher levels to page table traversals.
>>
>> All the patches were sent separately to the respective arch lists and
>> maintainers hence the "v2" prefix.
> 
> You fail to explain why this change which adds 488 additional lines of
> code is desirable.
> 

The purpose of the series, ie droping a HACK, is worth it.

However looking at the powerpc patch I have the feeling that this series 
goes behind its purpose.

The number additional lines could be deeply reduced I think if we limit 
the patches to the strict minimum, ie just do things like below instead 
of adding lots of handling of useless levels.

Instead of doing things like:

-	pud = NULL;
+	p4d = NULL;
  	if (pgd_present(*pgd))
-		pud = pud_offset(pgd, gpa);
+		p4d = p4d_offset(pgd, gpa);
+	else
+		new_p4d = p4d_alloc_one(kvm->mm, gpa);
+
+	pud = NULL;
+	if (p4d_present(*p4d))
+		pud = pud_offset(p4d, gpa);
  	else
  		new_pud = pud_alloc_one(kvm->mm, gpa);

It could be limited to:

  	if (pgd_present(*pgd))
-		pud = pud_offset(pgd, gpa);
+		pud = pud_offset(p4d_offset(pgd, gpa), gpa);
  	else
  		new_pud = pud_alloc_one(kvm->mm, gpa);


Christophe
