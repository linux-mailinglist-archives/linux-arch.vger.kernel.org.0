Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32FBCE59F0
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2019 13:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfJZLUK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Oct 2019 07:20:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21036 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbfJZLUK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 26 Oct 2019 07:20:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 470dn23HVBz9vBLY;
        Sat, 26 Oct 2019 13:20:06 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VMwHltKJ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8T8h_3sGDPZb; Sat, 26 Oct 2019 13:20:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 470dn223dkz9vBLX;
        Sat, 26 Oct 2019 13:20:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1572088806; bh=cuRzeOKlaXy8moZYsilOlogmoVgTxTKDrbJaqzMZyMA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VMwHltKJYJQdbu7PK4+xV1Dr9Besk731Q47erS5k6wafk2Ix2XG/xyFnG7Pvv7Pg5
         SmFst9LS0rBqSvgtCWvAXLp7a5kvYO+9pNHWnD2vz3j6KcChDoxTB+LhKcXRTo1trv
         k1eZFRaooVdUouwfdY+ERrKOEab8qufUfRYCusww=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F33F8B7A8;
        Sat, 26 Oct 2019 13:20:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id F8WsoAjdIp8i; Sat, 26 Oct 2019 13:20:07 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD48D8B787;
        Sat, 26 Oct 2019 13:20:06 +0200 (CEST)
Subject: Re: loop nesting in alignment exception and machine check
To:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "alistair@popple.id.au" <alistair@popple.id.au>,
        "chengjian (D)" <cj.chengjian@huawei.com>,
        Xiexiuqi <xiexiuqi@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oss@buserror.net" <oss@buserror.net>,
        "paulus@samba.org" <paulus@samba.org>,
        "Libin (Huawei)" <huawei.libin@huawei.com>,
        "agust@denx.de" <agust@denx.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <D44062DC474617438D5181ADFE2B2C21016DE42A@dggemi529-mbs.china.huawei.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8215aeb3-57dd-223a-29d3-45ca22b0543c@c-s.fr>
Date:   Sat, 26 Oct 2019 13:20:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <D44062DC474617438D5181ADFE2B2C21016DE42A@dggemi529-mbs.china.huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Le 26/10/2019 à 09:23, Wangshaobo (bobo) a écrit :
> Hi,
> 
> I encountered a problem about a loop nesting occurred in manufacturing 
> the alignment exception in machine check, trigger background is :
> 
> problem:
> 
> machine checkout or critical interrupt ->…->kbox_write[for recording 
> last words] -> memcpy(irremap_addr, src,size):_GLOBAL(memcpy)…
> 
> when we enter memcpy,a command ‘dcbz r11,r6’ will cause a alignment 
> exception, in this situation,r11 loads the ioremap address,which leads 
> to the alignment exception,

You can't use memcpy() on something else than memory.

For an ioremapped area, you have to use memcpy_toio()

Christophe

> 
> then the command can not be process successfully,as we still in machine 
> check.at the end ,it triggers a new irq machine check in irq handler 
> function,a loop nesting begins.
> 
> analysis:
> 
> We have analysed a lot,but it still can not come to a reasonable 
> description,in common,the alignment triggered in machine check context 
> can still be collected into the Kbox
> 
> after alignment exception be handled by handler function, but how does 
> the machine checkout can be triggered in the handler fucntion for any 
> causes? We print relevant registers
> 
> as follow when first enter machine check and alignment exception handler 
> function:
> 
>           MSR:0x2      MSR:0x0
> 
>           SRR1:0x2      SRR1:0x21002
> 
>           But the manual says SRR1 should be set to MSR(0x2),why that 
> happened ?
> 
>           Then a branch in handler function copy the SRR1 to MSR,this 
> enble MSR[ME] and MSR[CE],system collapses.
> 
> Conclusion:
> 
>           1)  why the alignment exception can not be handled in machine 
> check ?
> 
>           2)  besides memcpy,any other function can cause the alignment 
> exception ?
> 
> We still recurrent it, the line as follows:
> 
>           Cpu dead lock->watch log->trigger 
> fiq->kbox_write->memcpy->alignment exception->print last words.
> 
>           but for those problems as below,what the kbox printed is empty.
> 
> ------------------kbox restart:[   10.147594]----------------
> 
> kbox verify fs magic fail
> 
> kbox mem mabye destroyed, format it
> 
> kbox: load OK
> 
> lock-task: major[249] minor[0]
> 
> -----start show_destroyed_kbox_mem_head----
> 
> 00000000: 00000000 00000000 00000000 00000000  ................
> 
> 00000010: 00000000 00000000 00000000 00000000  ................
> 
> 00000020: 00000000 00000000 00000000 00000000  ................
> 
> 00000030: 00000000 00000000 00000000 00000000  ................
> 
> 00000040: 00000000 00000000 00000000 00000000  ................
> 
> 00000050: 00000000 00000000 00000000 00000000  ................
> 
> 00000060: 00000000 00000000 00000000 00000000  ................
> 
> 00000070: 00000000 00000000 00000000 00000000  ................
> 
> 00000080: 00000000 00000000 00000000 00000000  ................
> 
> 00000090: 00000000 00000000 00000000 00000000  ................
> 
