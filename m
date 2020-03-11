Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7E0182499
	for <lists+linux-arch@lfdr.de>; Wed, 11 Mar 2020 23:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgCKWR7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Mar 2020 18:17:59 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53017 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbgCKWR7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Mar 2020 18:17:59 -0400
Received: by mail-pj1-f67.google.com with SMTP id f15so1653658pjq.2
        for <linux-arch@vger.kernel.org>; Wed, 11 Mar 2020 15:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nRYie0QyD+cdnhyddPb9ZD6MZri8AoRElYc1Lmc36hE=;
        b=e+V1sIESfX0FctKsPmQvgrEDc4zbPfgdr9ALswG6YdboRPAAfcRvBQkR2Q4av0ZVpN
         FYScNTZbenpdyA2htFDRlNsrMWF00GPDxFC1OCVkZfugBjd9PQWJq4TZP63Dqzci4+0Y
         mAqrh4aG5ekBqBm0iPNRj3MD4lal8Rre/NPxJebAUNhTYsipARs7EcLXB0GMAQQ65GAN
         fgDYmsLNIheUbFFGZsob4cz32SzBXbtShOntOwJNybjwA80gECzoNZDlN8YCt7bjrCsj
         nOPPwUzYST3PRS/gHU4ILUz7X8foFzcoturMNV0gqr2bQiw6uBa3hTXpknxyW5zRbRkY
         Okug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nRYie0QyD+cdnhyddPb9ZD6MZri8AoRElYc1Lmc36hE=;
        b=pMk1yavAYPszmlTrI4WcIwZyzOIH/zVrLTBI2B8oimWAl1bbXa+3rSt4Zt15Khryjm
         pogo2GeJU//Hf9Ya9sU41v7UPWZnLqwc6ou9FgVWyXYQgC5VHEZy3ahWtlQgKYyCl++o
         F7oqzjpSZbQqd6fx2nJ5y8T16MySeCATBpfD/rkVU8b3SbptPevhsYyuVpT2sACbOGrj
         8X8ed11+/eAfO9Egu8MD2LK1hxQR3uay+8eq+PFMjfgIjSLP57dUCzvPPP92+HvcLhfi
         K/TaRia2pGGxOV2Qlg6yJ+vopM3NtKe/FZdDb870lj4eDTvv84Vh9sfgJhAb4cqkAKa0
         T9rw==
X-Gm-Message-State: ANhLgQ3qo/B0W9m9RSL9eye5yLDvknaS/DwJ8Uhm5mlzBI5c726h2ERC
        tOVlABPczJLSayxYuqLLVkkM8Q==
X-Google-Smtp-Source: ADFU+vuqclAJuGflnAIq8cnrsyrMIS5uLHU9vn4bhcJZpIKT78qUgs2mCU42WQim5LsEXlDajXLjmA==
X-Received: by 2002:a17:902:9f86:: with SMTP id g6mr4715169plq.299.1583965078277;
        Wed, 11 Mar 2020 15:17:58 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
        by smtp.gmail.com with ESMTPSA id a3sm29439695pfi.161.2020.03.11.15.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 15:17:57 -0700 (PDT)
Subject: Re: [PATCH v2 19/19] arm64: mte: Add Memory Tagging Extension
 documentation
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
 <20200226180526.3272848-20-catalin.marinas@arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0857cca0-9f75-398d-e755-f645d2d8a594@linaro.org>
Date:   Wed, 11 Mar 2020 15:17:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226180526.3272848-20-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/26/20 10:05 AM, Catalin Marinas wrote:
> +    /*
> +     * From include/uapi/linux/prctl.h
> +     */
> +    #define PR_SET_TAGGED_ADDR_CTRL 55
> +    #define PR_GET_TAGGED_ADDR_CTRL 56
> +    # define PR_TAGGED_ADDR_ENABLE  (1UL << 0)
> +    # define PR_MTE_TCF_SHIFT       1
> +    # define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TCF_SYNC        (1UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TCF_ASYNC       (2UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TCF_MASK        (3UL << PR_MTE_TCF_SHIFT)
> +    # define PR_MTE_TAG_SHIFT       3
> +    # define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)

Is there a reason not to include TCMA into the set of bits that userland can
control with this prcrl?

I know that ordinarily TCR_ELx requires expensive syncing, but for this
particular field there is a note about "software may change this control bit on
a context switch".  Which I take to mean that the usual TLB-related syncing may
be omitted.


r~
