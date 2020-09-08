Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635022621E6
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 23:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgIHVXW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 17:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbgIHVXM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 17:23:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95715C061755
        for <linux-arch@vger.kernel.org>; Tue,  8 Sep 2020 14:23:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d9so243244pfd.3
        for <linux-arch@vger.kernel.org>; Tue, 08 Sep 2020 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ih6QbdC2BlMXbYNA/XrG1Rz+rSEU4l2iSukj1ZYcfcE=;
        b=W3Pr3JckrBkhsvVBPRqyalyPCHmDdjwsO8lMz82fl3992mSkJBCa/ynKYFlOpa29KS
         YrQvjiSk8Gsj+2F0XyIFg6bT/TX3bdtqIzg+X9zApTyghMxBvgeVK7VjGnj0Xvez1x1T
         vtDDvMHWVF2Q9VElpy4Et4CUBV2fAGlDpuHSIHxSfO2vTMGl2CEODJDA3aVOsYuSr2rb
         54oZUVIzZ6F0vJ0E2vHEj9aGY9uEozAJoPE35B9/ZkY30GF+FwBSaPHMJZxUW1Gwmrih
         hraJxCrNOD15xVsyVUJ11S0Z4yNK+aS0/3uKyQbwkUQtxQoq+M+Ub2vQlfRLbEhbUoo0
         TnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ih6QbdC2BlMXbYNA/XrG1Rz+rSEU4l2iSukj1ZYcfcE=;
        b=E2vZVoY++K/GJxsZasJSH+SBg5Ulr12KsrO2+CFd3tmwt4YafJALq/EcooP66bhoDw
         hPGHcVaplcEms1lEYiWRk51rVDYkl3fYE/x9Fr2ny+JbHimYqYU6nZFccdBE9BKvyLRa
         19A9+0CT3xmlGAByrnppO0ls2Wcil7p0su/jTuI5MxMLElVvaflv6u8MwZQ+z4hmOKY0
         vz4RvPn5WlL+xKRXOHigQZh4x2pZ8grkQXWjSS1sDc8w57LyIjgB988IhUPNsuo+KETj
         82BLOjY9x+udk5gkK26XN3B2DKM6uFc6Kvhb+jY6jS3HOE4LbRFiyP8s4Y6Vw8JtPRal
         2U7g==
X-Gm-Message-State: AOAM531zfTO7HBsOIfUuiTptrF/WnBdwJDjgy4acLrCX76ZATRB73BRc
        NECVOC3OQvGF7kW92Tw+VGCLXA==
X-Google-Smtp-Source: ABdhPJxZtQ6suAAYIvComwJnL/d5p58yR7wkXLgcU+gM/W/qIhxDDa8Jsi9la7BgYDO45OUXHd5G6Q==
X-Received: by 2002:a05:6a00:1356:b029:13e:d13d:a084 with SMTP id k22-20020a056a001356b029013ed13da084mr947839pfu.27.1599600189879;
        Tue, 08 Sep 2020 14:23:09 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id gk14sm161668pjb.41.2020.09.08.14.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 14:23:09 -0700 (PDT)
Date:   Tue, 8 Sep 2020 14:23:02 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 22/28] arm64: export CC_USING_PATCHABLE_FUNCTION_ENTRY
Message-ID: <20200908212302.GD1060586@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-23-samitolvanen@google.com>
 <202009031544.D66F02D407@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009031544.D66F02D407@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 03:44:18PM -0700, Kees Cook wrote:
> On Thu, Sep 03, 2020 at 01:30:47PM -0700, Sami Tolvanen wrote:
> > Since arm64 does not use -pg in CC_FLAGS_FTRACE with
> > DYNAMIC_FTRACE_WITH_REGS, skip running recordmcount by
> > exporting CC_USING_PATCHABLE_FUNCTION_ENTRY.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> 
> How stand-alone is this? Does it depend on the earlier mcount fixes?

It does, because exporting CC_USING_PATCHABLE_FUNCTION_ENTRY doesn't
change anything without the earlier mcount changes.

Sami
