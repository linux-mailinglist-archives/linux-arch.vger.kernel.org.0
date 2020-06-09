Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF721F450E
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 20:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbgFISL0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jun 2020 14:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388145AbgFISLW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2020 14:11:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E039DC05BD1E;
        Tue,  9 Jun 2020 11:11:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t18so22392625wru.6;
        Tue, 09 Jun 2020 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qgCbHMP6AVsGQBCrGpsb15Exk7Vp+Gh9P4NumeRLi+Y=;
        b=qi5HMKbBPL1Bh6aQC3t5d2/Dp3Eie7JwKbgSTjHdzQFRybqrLqFuLGnTlRsQLSiERd
         p9FIccIt9Yvio8fbR/sn66MTqroj7M/PJ6vGTCoM/1ifBlTKGXJZzfxedzuo+XpkNSSE
         IFHYIuz0f//LFRc95jJDMFWGX3KEHu4NbEMcEyikMwZHMmjGkPsPANc3KTcysyCqsjb4
         A2TQ7k5KZqLbnTHC0ZDu4i9HuX0NBRmgD6DqVpDLA0mb93UOkM8lfeOam9wyy3NykEFj
         60bHhrMas0QEU6u6rxNWZPlX8I6begbQsWbkGqJC8vnQjoLzBbjAkZQRbx2tzQp6W847
         UzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qgCbHMP6AVsGQBCrGpsb15Exk7Vp+Gh9P4NumeRLi+Y=;
        b=EEZNRihAOF0ugyaKQykb0ASVkHzJfkrot6ty1oYPKLSCimYLmOhVaJmWrVA00JCkEA
         a5JCEX+MAa9uiTFz5YIkRbuRFqbgy+9cyGqZsdI/GL3OO9ecmd2T2PKeD4tSjY0lA/T5
         eY4A6mxdR4gBk+cGcW/FuszovG716TRuTlZycv0ZzBysLjD+aPt1GinUv8XF1OfniAfo
         Pao0B2pTFZePdgQpvYDMVmfwwvwgkgjjZckraX7ZBI42Th5CS8Qx53iaMkUFhBpIJyRD
         OG8px/G7mwrG98MGLHRK1rjHtA1xCL869WG0T/jri+MNyNxPwmDQPHc1pfZHijk+cYX4
         riFg==
X-Gm-Message-State: AOAM533nPaKPu+LBT5fW97OKAUeLe4vbOEQBKZqiLe7UFvll26FbEb8j
        KCLpmxnrTF84B0YmQBJKsZ0=
X-Google-Smtp-Source: ABdhPJyRGm0pc16LQUVQ2F4WFKqMsY2eImNCDmlPz96bHf801beZrkCemV7u8X7ypYSStxjbDFNhhA==
X-Received: by 2002:a5d:6444:: with SMTP id d4mr6022286wrw.239.1591726280543;
        Tue, 09 Jun 2020 11:11:20 -0700 (PDT)
Received: from ?IPv6:2001:a61:253c:8201:b2fb:3ef8:ca:1604? ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id b132sm3738724wmh.3.2020.06.09.11.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 11:11:19 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/6] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
To:     Dave Martin <Dave.Martin@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-6-git-send-email-Dave.Martin@arm.com>
 <1084d017-54f3-475c-be1b-aabc801d9a71@gmail.com>
 <20200609141620.GC25945@arm.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <0dce173d-25f9-fcce-cfa6-b4d8d96c906c@gmail.com>
Date:   Tue, 9 Jun 2020 20:11:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609141620.GC25945@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>> I applied the following change after your patch; is it okay?
>>
>>  .IP
>>  .B Warning:
>>  Because the compiler or run-time environment
>>  may be using some or all of the keys,
>>  a successful
> 
> Looks fine, execpt that I think you need to move the
> 
> 	.B PR_PAC_RESET_KEYS
> 
> line here also.

Thanks. Fixed. But, the fix will be in the 5.08 man-pages release,
I'm sorry. I cut 5.07 a few hours ago.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
