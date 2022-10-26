Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E407860E4F4
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 17:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiJZPlk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Oct 2022 11:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiJZPlj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Oct 2022 11:41:39 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B49BE073F
        for <linux-arch@vger.kernel.org>; Wed, 26 Oct 2022 08:41:38 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d24so14483990pls.4
        for <linux-arch@vger.kernel.org>; Wed, 26 Oct 2022 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cEIES9uoI6udr7n0rwDVmg+JFtlw13MTcmUB6NYS/Fs=;
        b=mNMDzf7LqnhsTxfEgDLr6FNzx9lpzODWlhl8Q8L8+iYUYSgbt6RtNYbc6GlfeRvDYV
         xcLawmPkaG1E0TGfjOdmVTHe3qkBlZTe6Y5V+o3FKz6thO9oXljGO6sVXa5qhFY109Tg
         FMmn/0GS+49mB2JnREnsggHuxqU6sSafXueBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEIES9uoI6udr7n0rwDVmg+JFtlw13MTcmUB6NYS/Fs=;
        b=Vlq3Iyqdf/+KuYz6YNJ3T3106vwgQ/kVNsCLluOTjvc617LCcc88cMAjeKM2kQHiHu
         Ez6aak/pDV4V6wVQGAjXEyLljkB008/DdH0XX1EYZJx6myOy6TKnEh5paB76EAmUplXm
         /jFcFIZMP5poMf9tWH2Qb5yTTBWGpOtmgZtoAbHbIAx2gQhm7m/I6E4quU5lIRvLqCHK
         wGKT+MbP7qXI5S1mUeYB3+EeXvm+zmackmqFQKVi3FUqpDz+7CKl00tVbJaY3wvafk/C
         U13c8eqi5BXmPO4UjTP/Xq30O9a+EaQN1TOPlOhJGOyt76ORwkoLrhC05EVmKVxB3qla
         Y89g==
X-Gm-Message-State: ACrzQf1MVQsliNrjjET+z4WZgkpa0ZhVhyfNzLCddy1Bu95Opv2+TsSP
        bYPYfbS1X5D/isX2FdDKLIRVEQ==
X-Google-Smtp-Source: AMsMyM6g03QtM2lxxRFFtJpX8fOsFfXKZnEtb1T+ZA1Qb42N5pHM0lMkBPYTSbh0DN2bqHcDkzPzjw==
X-Received: by 2002:a17:90b:110c:b0:205:cfeb:cfb with SMTP id gi12-20020a17090b110c00b00205cfeb0cfbmr4947459pjb.75.1666798897930;
        Wed, 26 Oct 2022 08:41:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a64-20020a621a43000000b00528a097aeffsm3143679pfa.118.2022.10.26.08.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:41:36 -0700 (PDT)
Date:   Wed, 26 Oct 2022 08:41:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Gabriel Paubert <paubert@iram.es>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kbuild: treat char as always signed
Message-ID: <202210260840.475445C@keescook>
References: <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org>
 <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
 <Y1Elx+e5VLCTfyXi@lt-gp.iram.es>
 <CAHk-=wiYtSvjyz5xz2Sbnmxgzg_=AL2OyTiRueUem3xzCzM8VA@mail.gmail.com>
 <Y1OIXdh3vWOMUlQK@lt-gp.iram.es>
 <CAHk-=wgaeTa9nAeJ8DP1cBWrs8fZvJ7k1-L8-kjxEOxpLf+XNA@mail.gmail.com>
 <Y1Wi29MuYlCRTKfH@lt-gp.iram.es>
 <202210251555.88933A57F@keescook>
 <Y1h5jr/ZS7BORewp@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1h5jr/ZS7BORewp@zx2c4.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 26, 2022 at 02:04:30AM +0200, Jason A. Donenfeld wrote:
> ... (Once the
> -funsigned-char changes go in, though, we should probably decide that
> s8[] is never a valid string.)

Yeah, that's my goal too.

-- 
Kees Cook
