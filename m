Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B4709D7F
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 19:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjESRGQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 13:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjESRFq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 13:05:46 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3C1E5C;
        Fri, 19 May 2023 10:05:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3FF7B7C0;
        Fri, 19 May 2023 17:05:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3FF7B7C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684515921; bh=32yUJ/Ep+SRRswkhu8CSGkcBJ2kdTHXVgiH1bkIO4qs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Sz93O2MrDkbaobmjkJ4YaHN0AUsD9dSLwiu3oH8qY4OEUKIHsY0wZxUduPTtQiDGm
         F6EjFmjz4TlLD5IYnTPhc007iYrszZr4V5JyctI/kGhBb1Pqxf37RXfMsiP2DzS6re
         Sy0+VaKsJIfemyC0l+d2yBBLQks8akk4UaK6GRUZuIQ47YAGOajWtf66psmV+IdXtc
         7az6kUp5rKGdc9B0V326bC75avIMUS4DPGYYd8QZwOL9SHfYewwv2ZVP5glXpAm/fp
         xgu5x8yS+QifekV7BKMjJt9KX5ewJhXJ/7AgXYsVCnXAUlupWqmEHvFntzHAciAEtR
         tzl6G8QjkX3dg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 7/7] dt-bindings: Update Documentation/arm references
In-Reply-To: <20230519-tug-garbage-4fee2efc3f0a@spud>
References: <20230519164607.38845-1-corbet@lwn.net>
 <20230519164607.38845-8-corbet@lwn.net>
 <20230519-tug-garbage-4fee2efc3f0a@spud>
Date:   Fri, 19 May 2023 11:05:20 -0600
Message-ID: <877ct4meun.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Conor Dooley <conor@kernel.org> writes:

> On Fri, May 19, 2023 at 10:46:07AM -0600, Jonathan Corbet wrote:
>> The Arm documentation has moved to Documentation/arch/arm; update
>> references under arch/arm64 to match.
>
> This commit message seems a wee bit inaccurate ;)

Argh.  I pulled this change out into a separate patch because checkpatch
whined at me, and did it a bit too quickly, I guess...

>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>> Cc: Conor Dooley <conor+dt@kernel.org>
>
> Otherwise,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,

jon
