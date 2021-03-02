Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298D632B4B7
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354157AbhCCF0S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:26:18 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:27539 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243168AbhCBRkL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 12:40:11 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dqkrm1zSMz9v1C4;
        Tue,  2 Mar 2021 18:39:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id D8Iy4UnBz9qu; Tue,  2 Mar 2021 18:39:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dqkrm16TKz9v1C3;
        Tue,  2 Mar 2021 18:39:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE8E28B7B5;
        Tue,  2 Mar 2021 18:39:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KNtgQj-59fjm; Tue,  2 Mar 2021 18:39:05 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 484C18B75F;
        Tue,  2 Mar 2021 18:39:05 +0100 (CET)
Subject: Re: [PATCH v2 0/7] Improve boot command line handling
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <20210302173523.GE109100@zorba>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <56c3b0a7-95bf-43ef-a285-068cca5f28d8@csgroup.eu>
Date:   Tue, 2 Mar 2021 18:39:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302173523.GE109100@zorba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 02/03/2021 à 18:35, Daniel Walker a écrit :
> On Tue, Mar 02, 2021 at 05:25:16PM +0000, Christophe Leroy wrote:
>> The purpose of this series is to improve and enhance the
>> handling of kernel boot arguments.
>>
>> It is first focussed on powerpc but also extends the capability
>> for other arches.
>>
>> This is based on suggestion from Daniel Walker <danielwa@cisco.com>
>>
> 
> 
> I don't see a point in your changes at this time. My changes are much more
> mature, and you changes don't really make improvements.
> 


Cool, I'm eager to see them.

Christophe
