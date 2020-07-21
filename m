Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E956A227E1A
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 13:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgGULGL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 07:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgGULGL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:06:11 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4909C0619D8
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 04:06:10 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so2425654wmf.5
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JitW8E/Uo2q1CMw7tRyORpusuSv9wng9iRv55mMDpbM=;
        b=B/VxyHE+rLfsoKJ8ka63SleoGdHvpRkyF3TPlMJr4lQ3bV1Un3j33BBXD/2PQvMEvF
         VQj56ZmISMzBYley/bDL40+gWhW5KSsNGMgAxmcw+jTW3Y3CewGYuPQH0q1Y7X3UDNRP
         eSfy33KTK0oULpx1QABgxb5wtSO0MlOGLe7A51hs/KSTr0zR1gyfmDNsT5pSUDhXuZaX
         VYsGbyMAcx0pu0nVfVlVy2A66G4XjAszNXvMiPKvx21XUS+sNQ8P16nS1Ki1XU+tTOzh
         CBB/upgPpAYQ/WpX5QUtMK5NakqgbXHyzMlWFTYT1si0PrDgDmHsDSkm1ifuEQpiU+cD
         caIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JitW8E/Uo2q1CMw7tRyORpusuSv9wng9iRv55mMDpbM=;
        b=aBDEh3ANq5BPIctlFkOjOTeAklHy5y0fKwtA3iSr5jAZYNTTbURSFzPgNQOONPD7gb
         1a3Db45/bLzFy2lVAsSJkxVkjZ9W6ZhYUHQgf3yu+2OSU1Czi5dtO5g5rUzsNpWhTqD2
         H6FVrIfYWC4ASb1Q8exXj+IapJDO9KIFo47MtHFQUpuLfRhF2qiLDLx6FmHbHY22G63E
         8Yfr5dGArQ2kTYCWSia/muTyMI2oMbDwVc7pepctOnzH/dADx2P/WCEtHA2Lwx5ZRmPD
         ZxpR2fw+jqOPMjs82QfBdhMWTUlCsD0D8m1YUnb+eqIu42z8hKCYmJznCxCi1MbkGJ+C
         LHwg==
X-Gm-Message-State: AOAM530lu/Gp4dQ7LIsDZYTQt0muqd678Bb6sVZiZ8WM4pqMCVhvpa4e
        NHo83ukfiadC115PS8W8LWlJcQ==
X-Google-Smtp-Source: ABdhPJxQdglCU5W1O7rWIMy+ncr+WI4GmlDvpZQNlWXa/gjqC53IcptHZ0EoFkv8bXMa7IDxZX+0nA==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr3478083wmk.175.1595329568258;
        Tue, 21 Jul 2020 04:06:08 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id s8sm37009753wru.38.2020.07.21.04.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 04:06:07 -0700 (PDT)
Date:   Tue, 21 Jul 2020 13:06:02 +0200
From:   Marco Elver <elver@google.com>
To:     paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/8] kcsan: Test support for compound instrumentation
Message-ID: <20200721110602.GA3311326@elver.google.com>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-6-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721103016.3287832-6-elver@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 12:30PM +0200, Marco Elver wrote:
[...]
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 3d282d51849b..cde5b62b0a01 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -40,6 +40,11 @@ menuconfig KCSAN
>  
>  if KCSAN
>  
> +# Compiler capabilities that should not fail the test if they are unavailable.
> +config CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
> +	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-compound-read-before-write=1)) || \
> +		 (CC_IS_GCC && $(cc-option,-fsanitize=thread --param -tsan-compound-read-before-write=1))
> +
>  config KCSAN_VERBOSE
>  	bool "Show verbose reports with more information about system state"
>  	depends on PROVE_LOCKING

Ah, darn, one too many '-' on the CC_IS_GCC line.

	s/--param -tsan/--param tsan/

Below is what this chunk should have been. Not
that it matters right now, because GCC doesn't have this option
(although I hope it gains it eventually).

Paul, if you prefer v2 of the series with the fix, please let me know.
(In case there aren't more things to fix.)

Thanks,
-- Marco

------ >8 ------

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 3d282d51849b..f271ff5fbb5a 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -40,6 +40,11 @@ menuconfig KCSAN
 
 if KCSAN
 
+# Compiler capabilities that should not fail the test if they are unavailable.
+config CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
+	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-compound-read-before-write=1)) || \
+		 (CC_IS_GCC && $(cc-option,-fsanitize=thread --param tsan-compound-read-before-write=1))
+
 config KCSAN_VERBOSE
 	bool "Show verbose reports with more information about system state"
 	depends on PROVE_LOCKING
