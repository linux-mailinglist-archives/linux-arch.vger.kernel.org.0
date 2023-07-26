Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49B37638D8
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jul 2023 16:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjGZORC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jul 2023 10:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjGZOQp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jul 2023 10:16:45 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783403C24;
        Wed, 26 Jul 2023 07:15:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6687466137bso4125507b3a.0;
        Wed, 26 Jul 2023 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690380936; x=1690985736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el9FDIpNxZA/2ZC95S3R2A6ZaUwseRaIBBOHwXwowDY=;
        b=BKbeSrIGFLVGyS+4l3JPh8gDZPhSmkxN0WP3+1YVRAVDQOFE0Z6VT5Yza28WhUokEF
         Ow0lIgWztT5QSlt3+UiBtN2gowF2Hwe9tH90vkvZBkMp95yQ7OWorcterR093H6QmDjG
         FGQMjRPSlvn/vw0xzAyAeEK5hN4T5JV9T5Wm8qyQo1J+QHe3JP4B05tc65WJcmpj7NKr
         RicCmhi5xOxU43Ev7E8Rvc4dhkdFEh8mJfDQfKCTA7TV4Vuui6TYEWbBSJZLnEYd2vaq
         qyRiUh2FIV/bvDipPTGQFKtgvdBCFRyMsGfbCi0jkJ70kaUKlwH3JytNlr+BD+6McVcQ
         X35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380936; x=1690985736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=el9FDIpNxZA/2ZC95S3R2A6ZaUwseRaIBBOHwXwowDY=;
        b=DVPcaGQZdIN84yVVo1yYLceBmgCK6IKA72gnXcdy6QPXp3e/jOVotd2cKll8BI0be2
         twsBttrA0YFQ/gsudrT54XctnslEPlnx7vJcbOzhHTpicJ0qeCd6TgYVsDOIpXAvFQ+u
         I2UhMbumkmofFTKAKh0mLxx5iWXbxWmMIJPkV6KOmXVPTD5PI7ngskeUr2k7XGcQV1M2
         wyIbEVU8bIaYHYnpqD+XacLFKu5WhR7mOvQ/e/G+DfaRGT/mKyQ+ZegwhsqI1mpQbGqm
         vHTRXbD/F8xewbaIqr8IeweyAfOJh+mtMpdhHj6IQmccCy0W2L3orhduy9eF2FHmqRzE
         sd4g==
X-Gm-Message-State: ABy/qLaz7wrumLcGnwy3dTaR0fCinEooxj2Mzf8fVLhzAe/PBc7FLohR
        gw4GGeSgY2OxrgJyX6hkgGE=
X-Google-Smtp-Source: APBJJlFQmailWGHU3xp9sIJmNsRNgXZABPb5xpLi/BdLcjnDfmOs4x0oLpjwI2/E3Lab9dcosN+ZyA==
X-Received: by 2002:a05:6a20:3954:b0:131:eeba:1317 with SMTP id r20-20020a056a20395400b00131eeba1317mr2130178pzg.32.1690380936611;
        Wed, 26 Jul 2023 07:15:36 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id jd19-20020a170903261300b001bb99ea5d02sm7414129plb.4.2023.07.26.07.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 07:15:36 -0700 (PDT)
Message-ID: <9c690209-4a1c-842f-064b-66ae5c8d870f@gmail.com>
Date:   Wed, 26 Jul 2023 22:15:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH V3 7/9] x86/hyperv: Initialize cpu and memory for SEV-SNP
 enlightened guest
To:     Jinank Jain <jinankjain@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
References: <20230718032304.136888-1-ltykernel@gmail.com>
 <20230718032304.136888-8-ltykernel@gmail.com>
 <4d0715a5-70a8-9667-ccf0-de9bc933bb04@linux.microsoft.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <4d0715a5-70a8-9667-ccf0-de9bc933bb04@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/26/2023 12:26 PM, Jinank Jain wrote:
>> +    /*
>> +     * Hyper-V SEV-SNP enlightened guest doesn't support ioapic
>> +     * and legacy APIC page read/write. Switch to hv apic here.
>> +     */
>> +    disable_ioapic_support();
> 
> Where are we switching hv_apic? May I am missing something here?
>

Nice catch! It's fossil comment when there is no x2apic support.
Will fix it in the next version.

