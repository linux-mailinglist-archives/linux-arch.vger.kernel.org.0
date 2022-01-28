Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579CD49FB59
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jan 2022 15:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347022AbiA1OJw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jan 2022 09:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244803AbiA1OJw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jan 2022 09:09:52 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9627C06173B
        for <linux-arch@vger.kernel.org>; Fri, 28 Jan 2022 06:09:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s9so11112749wrb.6
        for <linux-arch@vger.kernel.org>; Fri, 28 Jan 2022 06:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c0MbAYZn48s/2sw8+6sJEGK9DVzD/LP2yU/tzes0Wew=;
        b=KnoYpCROJNJ4KeVjiMHVRjI3Nw6MBdLiVMYBKyWi5SjTGkUNhmLXnrLxkxBTE/uvzm
         1i7z3jyz9HYmoZNAG5Loy00qH2mtg+iFqBgPPlltZlvuAUpVQzHJC/Zh5YvuO8bbiuKV
         EhY0GkfgFO0pVCtVfHeoBwIMjXpF7AfmFwBBlSPZrfauweTohE5pmPCqYrkC4s7Xusfz
         4HPmI5qzz1+q+sdmUh4Ity1hlHsWh5wpsKT4x8GRkQTfDY1KyAL6lGRKpMiXEM/O84+/
         bEb7k6+NG5FdGoGanjw1rOia/TgJAtC6p47O0pODeUAm6OEJWTT+h5i60wvVX+nLYbKo
         twmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c0MbAYZn48s/2sw8+6sJEGK9DVzD/LP2yU/tzes0Wew=;
        b=NR5Dv4tYun2IxMR5vQLakZULdc4OI5CIok/wJaK/wUtdp7YipnQB8oKE31ogcaXPif
         D7XrHv+q8TwyfKCaOYc7emsVx7rTOkxLG58P2e5WH/Y+9CdFvPB2xbwDEhF/Q1YH5seU
         KeLY9bulLCzdW3xCYGCwxle/i1RE/HEA/5VWNMjCUiYiS/xaImCtpAt79pVAj2ACEqrf
         x2icxUnviNUrddjHqyWTH/YXflODCvQSzxUrVKxC+h44yc/sy3aSaiTATiaYcmBnu83h
         utp78IU1mVoKeoCJHPcbJ2dzUbVvlvUvuDgIhqGMD3UQwD8+i+1yFFQKOiXjb1SsFb08
         pLEw==
X-Gm-Message-State: AOAM531JxNY1TOXknq6BSK5SwwUANshiPSxY9NmM6aIN16hg0vHlPCk7
        HasXrTHKYNIOVlh6f1XPMgVBq2bYsxMJ58sw
X-Google-Smtp-Source: ABdhPJwcwaW5k4PCVMl0xIx5mubfMQwAXKgrPRB+Y2ibDaLBwjoVmYeQufxi/ZaCrtP5AiArmXZMSw==
X-Received: by 2002:adf:d1ed:: with SMTP id g13mr7395000wrd.477.1643378989779;
        Fri, 28 Jan 2022 06:09:49 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id w22sm4811774wra.59.2022.01.28.06.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 06:09:49 -0800 (PST)
Date:   Fri, 28 Jan 2022 14:09:47 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 4/5] modules: Add
 CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
Message-ID: <20220128140947.n2xea77txqohfbfj@maple.lan>
References: <cover.1643282353.git.christophe.leroy@csgroup.eu>
 <af8519537d2a5c36b71a2f48ba9b81c07c93a5c4.1643282353.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af8519537d2a5c36b71a2f48ba9b81c07c93a5c4.1643282353.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 27, 2022 at 11:28:09AM +0000, Christophe Leroy wrote:
> Add CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC to allow architectures
> to request having modules data in vmalloc area instead of module area.
> 
> This is required on powerpc book3s/32 in order to set data non
> executable, because it is not possible to set executability on page
> basis, this is done per 256 Mbytes segments. The module area has exec
> right, vmalloc area has noexec.
> 
> This can also be useful on other powerpc/32 in order to maximize the
> chance of code being close enough to kernel core to avoid branch
> trampolines.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>

Thanks for diligence in making sure kdb is up to date!

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
