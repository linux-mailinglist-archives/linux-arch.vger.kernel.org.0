Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2615338400
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 03:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhCLCuy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 21:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhCLCud (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Mar 2021 21:50:33 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766A0C061765
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 18:50:33 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso7802339pjb.4
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 18:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KIk3Qle+BUsBeCAQycfR+lWVDkST8GkFi9wSAJ/kiAg=;
        b=gaAUqBZl7VidujMHHgtZeA9Q5o5T4yTMa+Mfcm1wWfqy1OpliQkGvD/DCYzfxEeSLL
         mDO9Kkp+4pfOQRwDcV0GOLSdFkIdBuELW21sTwrdxjOLa06icoLqesEfjuRfSfkbNz/7
         TyqTR6nQkuhk2OjDCpKT9lbxEDST5JhduvaJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KIk3Qle+BUsBeCAQycfR+lWVDkST8GkFi9wSAJ/kiAg=;
        b=RyEGBXJUCRT/otkMaYVc/qDOoTV+9SRCk5BhtO+Pkd4Gz1kbZWBSI6n/uEJKa/4FR9
         o6Dv9aRGlZXrbWKRsCtjTuZCFH2Cm7UyouvldClELw02EtO+hyLv+Rb5aZ/BVl/jY/dH
         wlrZ2llhN3mwbdCnhZyIAlEmnSN3jQVgmTR4mrdCZ4OW+5fl8v2eGYcgET5aAuuycwGc
         m2rcvO+KkUVhcokebcwHrbqTSe3nQKPRK4JmDUuPq10OMG+zQr+OwMastu+FqGlLpo3j
         FeWRYZURBFIIcSePzFxgqk0OZ2LEH7S17HcBUZvgzs/7YpE0hOKbxSUoD3wSJMMR34by
         9Bqg==
X-Gm-Message-State: AOAM533JdGA9EhfcoAzozN7lWuGqtxnma9e9UQVm1NFof1dnG4Ww9qdh
        d1EvC5pkIX3E+A7n10/fuJeGKA==
X-Google-Smtp-Source: ABdhPJw0xZuePYZII/VnCaft+tZdrW5vwu4SWxI9nYaEkp6DHSxNhqBlAcK8pKbEPNeLsU/yPQL/MQ==
X-Received: by 2002:a17:903:2301:b029:e4:9026:4c7b with SMTP id d1-20020a1709032301b02900e490264c7bmr11209369plh.76.1615517432925;
        Thu, 11 Mar 2021 18:50:32 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fr23sm403194pjb.22.2021.03.11.18.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:50:32 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:50:31 -0800
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
Subject: Re: [PATCH 15/17] arm64: add __nocfi to __apply_alternatives
Message-ID: <202103111850.4C29C4C47@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-16-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-16-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:17PM -0800, Sami Tolvanen wrote:
> __apply_alternatives makes indirect calls to functions whose address
> is taken in assembly code using the alternative_cb macro. With
> non-canonical CFI, the compiler won't replace these function
> references with the jump table addresses, which trips CFI. Disable CFI
> checking in the function to work around the issue.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
