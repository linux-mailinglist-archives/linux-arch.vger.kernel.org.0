Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082A9276C20
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 10:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgIXIiD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 04:38:03 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:60694 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgIXIiD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 04:38:03 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1kLMlJ-0004in-W3; Thu, 24 Sep 2020 08:37:58 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1kLMlH-0003NK-OF; Thu, 24 Sep 2020 09:37:57 +0100
Subject: Re: [RFC v6 01/21] um: split build in kernel and host parts
To:     Hajime Tazaki <thehajime@gmail.com>
Cc:     linux-arch@vger.kernel.org, tavi.purdila@gmail.com, richard@nod.at,
        jdike@addtoit.com, linux-um@lists.infradead.org,
        retrage01@gmail.com, tavi@cs.pub.ro,
        linux-kernel-library@freelists.org
References: <cover.1600922528.git.thehajime@gmail.com>
 <034e4235086fceb43659c679770b7088e974f5d7.1600922528.git.thehajime@gmail.com>
 <738c23cc-7c19-90b8-c0d3-1a56ad3fb3e3@cambridgegreys.com>
 <m2h7rn7f8k.wl-thehajime@gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <15b3793a-25c2-27ad-443d-28201790eee6@cambridgegreys.com>
Date:   Thu, 24 Sep 2020 09:37:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <m2h7rn7f8k.wl-thehajime@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 24/09/2020 09:26, Hajime Tazaki wrote:
> 
> On Thu, 24 Sep 2020 16:33:49 +0900,
> Anton Ivanov wrote:
> 
>>> The host build part has been implemented in tools/um so that we can
>>> reuse the available host build infrastructure.
>>>
>>> The patch also changes the UML build invocation, if before
>>>
>>>    $ make ARCH=um defconfig
>>>    $ make ARCH=um
>>>
>>> was generating the executable now this only generates the relocatable
>>> object.
>>
>> This will break packaging in all distributions. We need to figure out an alternative way which is backward compatible with their builds.
> 
> Hmm, I understand the situation.
> We may have to put additional steps after generating the relocatable
> object in arch/um/Makefile.

Cool.

I will go through the rest of the patches and if I notice something I will comment on specific ones.

Brgds,

> 
> -- Hajime
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
