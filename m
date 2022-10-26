Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2615E60DD1F
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 10:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiJZIfv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Oct 2022 04:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiJZIfu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Oct 2022 04:35:50 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA62C495D9;
        Wed, 26 Oct 2022 01:35:49 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id x2so13019568edd.2;
        Wed, 26 Oct 2022 01:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uv8qawsUmOo9AuZfM+lS+beTuCiP1fY4EhSrh4sMsbA=;
        b=vPF7/tlggAM5jdGNkqDhR2dzXan+uocBI0LKT0KZvQNjCfcsvuLe+gsQiDYre9kEVS
         DUO4WNXTLm5C/+6byyOntdJp0+XPIvpt8bCw+bDwnDqbp2DWq5cco4ziv1/XpZtxontB
         P6hn0zRmJELO00fosmaNQCKkvRjo14mFZKvdCk6IYXKHKFRMoTJfiI+4iXTFRJ+bmC10
         1PfyLS1M+QbdBPx2/oxwVW1c8zXPHy9Gxq7KUUc7Uis7RIiqFxrUaJXyvGeSyetjWwp6
         G/pM+apoFi6kk5RTHhufVGqE1hnfQrcHTvqqCPT8aL57NAya313HfUGaXH/KOL0bwckt
         UYyA==
X-Gm-Message-State: ACrzQf3w3H7h9XYL8ih5O/hTkbzK2E7CfAah4heaMVjKD4kpczWmGqhR
        Ka3MLD2++JRk2nqrua+y21D0LAi6nBoS7A==
X-Google-Smtp-Source: AMsMyM6sYc1fzwDQEo78SRf3saoHjQrC3Im6izpMePi1f3csy9SgYa/9YKgx5nnQLNM/TWm+3ViDOg==
X-Received: by 2002:a05:6402:550c:b0:443:7d15:d57f with SMTP id fi12-20020a056402550c00b004437d15d57fmr40034782edb.147.1666773347643;
        Wed, 26 Oct 2022 01:35:47 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906158e00b0078bfff89de4sm2620566ejd.58.2022.10.26.01.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 01:35:47 -0700 (PDT)
Message-ID: <2008526a-e0ca-7e67-cff6-b540d62e58c7@kernel.org>
Date:   Wed, 26 Oct 2022 10:35:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Michael Matz <matz@suse.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Borislav Petkov <bpetkov@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20220924181915.3251186-1-masahiroy@kernel.org>
 <20220924181915.3251186-7-masahiroy@kernel.org>
 <ea468b86-abb7-bb2b-1e0a-4c8959d23f1c@kernel.org>
 <alpine.LSU.2.20.2210251210140.29399@wotan.suse.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3 6/7] kbuild: use obj-y instead extra-y for objects
 placed at the head
In-Reply-To: <alpine.LSU.2.20.2210251210140.29399@wotan.suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 25. 10. 22, 14:26, Michael Matz wrote:
>> Ideas, comments? I'll send the attachment as a PATCH later (if there are
>> no better suggestions).
> 
> This will work.  An alternative way would be to explicitly name the input
> file in the section commands, without renaming the section:
> 
> @@ -126,6 +126,7 @@ SECTIONS
>                  _text = .;
>                  _stext = .;
>                  /* bootstrapping code */
> +               KEEP(vmlinux.a:head64.o(.head.text))
>                  HEAD_TEXT
>                  TEXT_TEXT
> 
> But I guess not all arch's name their must-be-first file head64.o (or even
> have such requirement), so that's probably still arch-dependend and hence
> not inherently better than your way.

The downside of this is that it doesn't make sure the function 
(startup_64()) is the first one. When someone sticks something before 
it, it breaks again. But leaving the decision up to the x86 maintainers ;).

Re. other archs, I have absolutely no idea (haven't looked into that at 
all).

thanks,
-- 
js

