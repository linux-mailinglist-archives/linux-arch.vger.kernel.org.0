Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97751C6EB2
	for <lists+linux-arch@lfdr.de>; Wed,  6 May 2020 12:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgEFKrd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 May 2020 06:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726906AbgEFKrc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2020 06:47:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA10C061A0F;
        Wed,  6 May 2020 03:47:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g12so2074578wmh.3;
        Wed, 06 May 2020 03:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bn8l4iq/kDr47VaFmt9THZoqkqCKyikbuRACxwF89WQ=;
        b=mpOFMn6VC2cMdi9cPFm/FAIPKXhSdPu+yxT2lAogq4IgkqNFxP7oo1Fqf4evOMHQ09
         7hvq+0BEglsI/B7XVotFtK3QbkUgmx5jujPHHaIPBNbIBAqdU72H9dB0SdWHuE5Fc4tx
         Vy269LWHj3B6z7pTxvAwlXyxP2FnCAvZgLqlc1p2uHD1ygCTT10llD1MwR46lMVTYfbc
         /iYujlDyCxrC7cCKiyb8+fimyYzHx5TKO1j+BnPr9jRpwZiGfCRK7ENdhCJ0f/g8Lasi
         cX2a5jnYh2DKCLnhXehduHSyZeH2c/Gr6IFv7YJ+1vfYPs9E+9S9ZFM19K4ejVlwfHLn
         SoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bn8l4iq/kDr47VaFmt9THZoqkqCKyikbuRACxwF89WQ=;
        b=EbHO2EzCihLsIDylVCKw4jl7fpkbUbEZoJSt0Mv9/LZHk01F0sksx5uzx/ktRvtHtr
         IjhTk9F6NY7JudD4Zci8sTrcudT5q3VEZ+1XqvJ3n5Q0ydeDF9LoAkbov3n8O09sotKC
         Zlk+TPnZdNHVdnqcCjRBjkddiiQvZmHI1ReKdrbGsbqUc2hazM0/RLnH98pNRlFMtl9Q
         mJEinhS/rY/Pl2Bq3F+D3aAEpZMa0lHfeeCDYcFD00RAzjFh7cRmPmSbf00uoLwLdMR7
         Wc4tQNf2T34UZclKl2k20j0vJicqs3pj6NZ6Jnp7bSrvrl5e+ZhxYG68RHaxbnFTnFTn
         zR6w==
X-Gm-Message-State: AGi0PuZZlNHElik1N18duOpEtewp+i36goxBb4XnWuyXIqJyuktjIqiv
        WNWwIwGt1qANl0SKs81u23I=
X-Google-Smtp-Source: APiQypLZvHp+DR8EzRb1U52DBzJ2NfFj0rnzFRgPKAsQFOQSfPze7TC2mHn4V2apS7ApMySs9jiuYg==
X-Received: by 2002:a05:600c:2c47:: with SMTP id r7mr3632755wmg.50.1588762050560;
        Wed, 06 May 2020 03:47:30 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id h188sm2667936wme.8.2020.05.06.03.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 03:47:30 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
To:     Dave Martin <Dave.Martin@arm.com>, Will Deacon <will@kernel.org>
References: <20200504153214.GH30377@arm.com>
 <20200505104454.GC19710@willie-the-truck> <20200505110519.GM30377@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <542d1191-5e89-2228-330f-ad2b65d5b897@gmail.com>
Date:   Wed, 6 May 2020 12:47:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505110519.GM30377@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> If people start shouting about a page getting too big or messy I can try
> to split it up.
> 
> Make sense?

Yes.

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
