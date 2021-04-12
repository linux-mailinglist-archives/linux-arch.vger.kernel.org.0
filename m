Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DF835C6B5
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 14:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbhDLMtt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 08:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbhDLMtt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Apr 2021 08:49:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A5C061574;
        Mon, 12 Apr 2021 05:49:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618231769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l/XIlOnCEFK6wDuZUWOcTRIzT0SyL7XB9TwDJmOc63k=;
        b=KwLew2aezRXKKOl6Pmjy0VKCuN+Gg2cN80wVBDPmGgpC26I54pVChs2mzOwwjq7rlbE4bL
        wwzx9G+wKLZxwK21mjzocbgSicynrp52mDNBj3bhxXjiy8GzRWQg2Sw2VBy9zRPiExfVIa
        GQde8qdyEknJInN0pvRtX08PtZEl4sh9BMtusOx/F1lOsFstPExBvKG4Gx/r4XSt0tQc+3
        SHl0+dGXaxoWeoLML7acFg6vpHw+AwHaeVIeOKqn5i8Qal3rFoOAaQcwwAC2DNgxUa+C/B
        etustzSxZsdmhNj4lzmWuswZq4zmKo3UZZpAdR9bOYkcy9mxSmlF4z5ueATQug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618231769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l/XIlOnCEFK6wDuZUWOcTRIzT0SyL7XB9TwDJmOc63k=;
        b=XAOOXk0TVAsPzEcoTVW4tVWa/HhqIhpKIomW9bTNeLJ821g8uwIaj2+g8oTfwzXJ9P2Sdn
        YMwkGedwPu2VniBQ==
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dima@arista.com, avagin@gmail.com, arnd@arndb.de,
        vincenzo.frascino@arm.com, luto@kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH RESEND v1 0/4] powerpc/vdso: Add support for time namespaces
In-Reply-To: <cover.1617209141.git.christophe.leroy@csgroup.eu>
References: <cover.1617209141.git.christophe.leroy@csgroup.eu>
Date:   Mon, 12 Apr 2021 14:49:28 +0200
Message-ID: <87mtu31xd3.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31 2021 at 16:48, Christophe Leroy wrote:
> [Sorry, resending with complete destination list, I used the wrong script on the first delivery]
>
> This series adds support for time namespaces on powerpc.
>
> All timens selftests are successfull.

If PPC people want to pick up the whole lot, no objections from my side.

Thanks,

        tglx
