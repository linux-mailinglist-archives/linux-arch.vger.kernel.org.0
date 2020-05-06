Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD021C6EB0
	for <lists+linux-arch@lfdr.de>; Wed,  6 May 2020 12:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEFKr2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 May 2020 06:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726906AbgEFKr1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2020 06:47:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E28C061A0F;
        Wed,  6 May 2020 03:47:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s8so1608466wrt.9;
        Wed, 06 May 2020 03:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qwb+qBipzy9Sya7/i7QPjcEXCofi8YMhsFWro1Oc+RU=;
        b=iNHOrRp2mE0AROquV0ABtVB4pPkIqmq1zsiSNLdh1QIAMoPxfIAN/lToK2MFBNv8Sa
         qVvW4rND/wj3c/3Un0pBbTEhDR6MKA9mKbNBw/0Tmc9LY7SWUiyijF3Td0/girB8R0AW
         Hq4dauMHgLSGzPhb7V4j7JqFr0/cwctcKqiEXRdPLmgX4CqcEzh53CXbHGWiHZxks7t0
         MWk178YsSWSts/XHDhk/u+gf3czvWptYIaHqNnk6W8htCtSbOA9wP0bWxUYP/tfkBeRb
         8KO2DW5h9+T8Ad2lJ5hVOCPoWb8eEoMD7TKXXPAsW2qoChMD65DNNeYeclKwS2a3ZlhV
         Dogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qwb+qBipzy9Sya7/i7QPjcEXCofi8YMhsFWro1Oc+RU=;
        b=RK3Nefx3mtIop3YGJ3cUWCgBu114vUESlP/vdHGB8RKiZos/p7CTTld7DvdRuMmSLj
         Bn1s/RojuYxy+udW2z3WOBljBz8DCOp3tk1Zacq88RQSKYi/psHAc4wP13Nhrm0878ZT
         W9/uUDoIAEm0BCg3E53E0xdSg3CAyuENpvlk90onZbDV9jZQi0fHSBler3xGuFHKQtsh
         TjDpbQ/nvzaD5V2y78uP2TpeTNazq6zWGWrrTQ0yxgAgUd2G+f9ZoLUIDxLCWchaRChg
         KXNno9hnkvkLxwn9hJPDmhNu3BZWBIW59q1/FSu3uV6mlc88YHJTwYyZitedSPrFQDmr
         ogxw==
X-Gm-Message-State: AGi0PuaCEDS0gmbRiWxHZulepW//GtHr1VkMGnDJWe9S8hwWKUynBDOs
        +dTiOtvehZTObjOrn4LtOtM=
X-Google-Smtp-Source: APiQypKkQc44H2sW3RvsPwpnIHotifwMHs+kmUEdtD1AuDynhFP8jY/kvzeUknnE5+vic3Ppzi0cKw==
X-Received: by 2002:adf:ce10:: with SMTP id p16mr8611378wrn.144.1588762046368;
        Wed, 06 May 2020 03:47:26 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id h10sm2013107wrv.29.2020.05.06.03.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 03:47:26 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
To:     Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>
References: <20200504153214.GH30377@arm.com>
 <20200505104454.GC19710@willie-the-truck>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <66fbca56-bed7-d36a-9f97-395a3d82565e@gmail.com>
Date:   Wed, 6 May 2020 12:47:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505104454.GC19710@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>>  * man2/arm64-ptrace.2 (or man2/ptrace.2arm64): new page:
>>    arm64 ptrace extensions
> 
> Michael has been nagging me on and off about that for, what, 10 years now?

Perhaps not that long, but a while now ;-).

> I would therefore be very much in favour of having our ptrace extensions
> documented!
> 
> We could even put this stuff under Documentation/arm64/man/ if it's deemed
> too CPU-specific for the man-pages project, but my preference would still
> be for it to be hosted there alongside all the other man pages.

Agreed; manual pages is I think a better place.

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
