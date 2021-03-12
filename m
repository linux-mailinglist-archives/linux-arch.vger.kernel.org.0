Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241D73383CC
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 03:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhCLCpe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 21:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhCLCpL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Mar 2021 21:45:11 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03ECC061574
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 18:45:11 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so4126874pjb.1
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 18:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RwJ0npvlf94WoHHNghlKh7pfAsSY3kaD5+gAJapol+w=;
        b=bpZBKNh/QL9GElmYyMVWjg0TXLHOvRLf/AJusUpMp5M9GhAoX1vyXiQO5qjooDTLBU
         JzoyxgAy+jtXqTW2nhjU+NFbBjWEh9Cnaiik7yl7LEJVvRol9EJH9gFiWziYFuLK0mlG
         LfGHNNjlBiC2I2x4tgijzQUT7YRqmnmrZhpM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RwJ0npvlf94WoHHNghlKh7pfAsSY3kaD5+gAJapol+w=;
        b=oaepTXfeBceX6u41x3OI/n/qCDCF9CG5CH/Lkl1NwYgbqlTKS3EfxNzbX4FLkLb0X9
         ipj2TR35yqDyOZgy36aYUemqQNiNVXR0MlZp5a1i/xxJTbMFhi9caCrAinyY74BwmQRb
         npGls0QtizLZoxE67FIeG8HJDu+aVI0rsjD9AFNxsYPbqvIqo/ANC3CsJbOLg1c4CD39
         gaE2TibD2JVN2S+vTCnAdrXboF8Q2KN88oHoD24j4YsfiribHi0xkRLwc56E+pPLu/zz
         Y30gzkCCrmFoWmUp+6SZSehZ+VwYOJgZakLXP9lDKoAYzVkeOmF9qUZxcwMMFUaMVC+w
         kxSw==
X-Gm-Message-State: AOAM533Lr16aYHr77bS0wJi77gCqh9B/02BsgiN+hJDK/5npVTHaMFxa
        KJshIfd0Jvgc7u4Vl4l5J1W60Q==
X-Google-Smtp-Source: ABdhPJx0aXaKeloHsr9QGNEEDau0lh32ZHQZJQ1m7oA0GayR5TMfTM/IufYD/dXI5ahtsSEzPZ6Xow==
X-Received: by 2002:a17:902:6b43:b029:e6:3d73:e9fb with SMTP id g3-20020a1709026b43b02900e63d73e9fbmr11384932plt.37.1615517111244;
        Thu, 11 Mar 2021 18:45:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h5sm3498426pgv.87.2021.03.11.18.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:45:10 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:45:09 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/17] kallsyms: cfi: strip hashes from static functions
Message-ID: <202103111843.008B935F8@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-8-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:09PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG and ThinLTO, Clang appends a hash to the names
> of all static functions not marked __used. This can break userspace
> tools that don't expect the function name to change, so strip out the
> hash from the output.
> 
> Suggested-by: Jack Pham <jackp@codeaurora.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

(Is it possible we could end up with symbol name collisions? ... though
I guess we would have had collisions before?)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
