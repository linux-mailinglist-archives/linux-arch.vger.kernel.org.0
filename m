Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8309876FBBF
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 10:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjHDINg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 04:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjHDINd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 04:13:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95994687
        for <linux-arch@vger.kernel.org>; Fri,  4 Aug 2023 01:13:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc3d94d40fso15388335ad.3
        for <linux-arch@vger.kernel.org>; Fri, 04 Aug 2023 01:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691136810; x=1691741610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VL7MGYaWLHKrafJNpDNrQV+kq/3HdTXOCqcOC2etLW4=;
        b=CJLYGjD0bhLHh1OXkkRsreZPkeVsxE7+g11O/hc8izookwuSJgZi9I/8JSNHysqXmK
         9eIDgpbjmiXH+IZ9+bUuoPUZagmJcvLEUULJN0R5fE/lmyhtXs8CDzi3T152BXMjoxcN
         7kaoXRTCpVWYZnWuspUM74X52V0EsOSSPhB/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691136810; x=1691741610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VL7MGYaWLHKrafJNpDNrQV+kq/3HdTXOCqcOC2etLW4=;
        b=JSXhYcCqHRuw88xIH2P/5kFVinZ1xRtIZbMxxY9whlr6epEK0ybGda6UJgLJJLgmSW
         +ju0E0SL/lT7JxbkdIMCPK2dxe8k3yiSh93X0rqrSAsqNpO5W7WB0umgn8/Yi+zV0R9S
         ZfeAD/3H9WwipH/Ywl7/uOOoF60uFJgjjAy+FlOfR4TXKgrBf09/hZ3MH7oagJJB4mxi
         oQh222YjLrivfE3j6kNOugvYTiPDibuw1ha7kUOJOGKQp04yF9HQbOQwJn6VWmNPir4p
         EPfKxyKVNqCn9fx2Vdpa3fmJb098NIJozO2Q+NXgoO0KQ2huBgSYmQZyIOcUaunVRua5
         3//g==
X-Gm-Message-State: AOJu0Ywy5BnnkdrWjNRmrnOsLipidlRMB1wEChPlYQ55PbO0e1DqXhbN
        daDoMZKtaxYQAjnkooUUyM7X9g==
X-Google-Smtp-Source: AGHT+IE83P9NE4z3R7foSEJsWYLcP/0QXiKnenMC8MJ7cfoR2ZxY4Mv/zhfiFYz+DdY0Sn/WVJ3P5g==
X-Received: by 2002:a17:902:bb82:b0:1bc:4030:1fb6 with SMTP id m2-20020a170902bb8200b001bc40301fb6mr1099637pls.21.1691136810155;
        Fri, 04 Aug 2023 01:13:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ji5-20020a170903324500b001bc445e249asm1128036plb.124.2023.08.04.01.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:13:29 -0700 (PDT)
Date:   Fri, 4 Aug 2023 01:13:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        yj.chiang@mediatek.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 04/10] ARM: syscall: always store
 thread_info->abi_syscall
Message-ID: <202308040113.5A35E32B4B@keescook>
References: <20210726141141.2839385-1-arnd@kernel.org>
 <20210726141141.2839385-5-arnd@kernel.org>
 <202308031551.034F346@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308031551.034F346@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 03, 2023 at 04:17:24PM -0700, Kees Cook wrote:
> Anyway, I'll keep debugging this, but figured I'd mention it in case
> anyone else had been seeing issues in here.

Okay, I think I have a working patch now. Sent here:
https://lore.kernel.org/lkml/20230804071045.never.134-kees@kernel.org/

-- 
Kees Cook
