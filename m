Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5E23CC99
	for <lists+linux-arch@lfdr.de>; Wed,  5 Aug 2020 18:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgHEQyE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Aug 2020 12:54:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39200 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbgHEQvv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Aug 2020 12:51:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BMHhd05b5z9vB7v;
        Wed,  5 Aug 2020 18:51:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XDMUEKcHu9Nb; Wed,  5 Aug 2020 18:51:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BMHhc689vz9vB7t;
        Wed,  5 Aug 2020 18:51:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0D6838B7ED;
        Wed,  5 Aug 2020 18:51:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Y_J6TVisphoA; Wed,  5 Aug 2020 18:51:46 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3EFD58B7EC;
        Wed,  5 Aug 2020 18:51:46 +0200 (CEST)
Subject: Re: [PATCH v10 2/5] powerpc/vdso: Prepare for switching VDSO to
 generic C implementation.
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com,
        anton@ozlabs.org, linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        vincenzo.frascino@arm.com, linuxppc-dev@lists.ozlabs.org
References: <cover.1596611196.git.christophe.leroy@csgroup.eu>
 <348528c33cd4007f3fee7fe643ef160843d09a6c.1596611196.git.christophe.leroy@csgroup.eu>
 <20200805140307.GO6753@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <7d409421-6396-8eba-8250-b6c9ff8232d9@csgroup.eu>
Date:   Wed, 5 Aug 2020 18:51:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200805140307.GO6753@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Again,

Le 05/08/2020 à 16:03, Segher Boessenkool a écrit :
> Hi!
> 
> On Wed, Aug 05, 2020 at 07:09:23AM +0000, Christophe Leroy wrote:
>> +/*
>> + * The macros sets two stack frames, one for the caller and one for the callee
>> + * because there are no requirement for the caller to set a stack frame when
>> + * calling VDSO so it may have omitted to set one, especially on PPC64
>> + */
> 
> If the caller follows the ABI, there always is a stack frame.  So what
> is going on?

Looks like it is not the case. See discussion at 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/2a67c333893454868bbfda773ba4b01c20272a5d.1588079622.git.christophe.leroy@c-s.fr/

Seems like GCC uses the redzone and doesn't set a stack frame. I guess 
it doesn't know that the inline assembly contains a function call so it 
doesn't set the frame.


Christophe
