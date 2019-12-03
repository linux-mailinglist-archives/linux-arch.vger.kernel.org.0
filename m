Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 076D810FA81
	for <lists+linux-arch@lfdr.de>; Tue,  3 Dec 2019 10:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfLCJMe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Dec 2019 04:12:34 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:34613 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfLCJMe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Dec 2019 04:12:34 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47Rx8J0kcjz9vBK7;
        Tue,  3 Dec 2019 10:12:32 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Oyk10zwb; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id tQkAB2K9bzU1; Tue,  3 Dec 2019 10:12:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47Rx8H6djZz9vBK2;
        Tue,  3 Dec 2019 10:12:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575364351; bh=Tfzyfftdxt7nNkAel0mvTxcsHw6cENeeVt1BDJa4Wwk=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Oyk10zwbEQZj+hz/ApbAX7bZU2VISoBlDzphx0qgX4vuGI5JovpO7+XhDvgSS4Ht7
         8HTSc9mACgVCHkmuTGygTYKD88Z8cVYQajNaAgNEy52275tEGgvrZkFa67Z5XWulIZ
         cL/BkLM5Crlkacm12sfXyMktVPVbHlCut51DSplo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 000188B7D7;
        Tue,  3 Dec 2019 10:12:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ni-i5GC6tlVU; Tue,  3 Dec 2019 10:12:32 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 79DBB8B787;
        Tue,  3 Dec 2019 10:12:32 +0100 (CET)
Subject: Re: [PATCH 0/9] Improve boot command line handling
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <cover.1554195798.git.christophe.leroy@c-s.fr>
Message-ID: <8eb90163-0e6b-c5ee-179a-c20773d54e58@c-s.fr>
Date:   Tue, 3 Dec 2019 10:12:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1554195798.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 02/04/2019 à 11:08, Christophe Leroy a écrit :
> The purpose of this series is to improve and enhance the
> handling of kernel boot arguments.
> 
> It is first focussed on powerpc but also extends the capability
> for other arches.
> 
> This is based on suggestion from Daniel Walker <danielwa@cisco.com>

Looks like nobody has been interested in that series.

It doesn't apply anymore and I don't plan to rebase it, I'll retire it.

Christophe


> 
> Christophe Leroy (9):
>    powerpc: enable appending of CONFIG_CMDLINE to bootloader's cmdline.
>    Add generic function to build command line.
>    drivers: of: use cmdline building function
>    powerpc/prom_init: get rid of PROM_SCRATCH_SIZE
>    powerpc: convert to generic builtin command line
>    Add capability to prepend the command line
>    powerpc: add capability to prepend default command line
>    Gives arches opportunity to use generically defined boot cmdline
>      manipulation
>    powerpc: use generic CMDLINE manipulations
> 
>   arch/powerpc/Kconfig                   | 23 ++------------
>   arch/powerpc/kernel/prom_init.c        | 38 ++++++++++-------------
>   arch/powerpc/kernel/prom_init_check.sh |  2 +-
>   drivers/of/fdt.c                       | 23 +++-----------
>   include/linux/cmdline.h                | 37 ++++++++++++++++++++++
>   init/Kconfig                           | 56 ++++++++++++++++++++++++++++++++++
>   6 files changed, 117 insertions(+), 62 deletions(-)
>   create mode 100644 include/linux/cmdline.h
> 
