Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2428EA35
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 03:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbgJOBey (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 21:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbgJOBeh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 21:34:37 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25E7C051128
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 16:05:44 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h6so1340621lfj.3
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlFvy8eyL04DCdB/CZCNzYgQ2J2bwqnrawGVF61K2Q4=;
        b=T4nkPbcrfWVzlUXPa2RR1CJimGsiGY65KGzNi9VNP62ZmKbMbTcQk0jIvKba4mQWTj
         Ql2R8WvQdFrPo1ebURmmR+z4SRbFVplsZde363RW7Z/ZsuQgnaSQ9O2JbS+GUN+LzQRD
         3lLLweu8MvSfGCWs26YQ2AN9k47D9sYkCWPjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlFvy8eyL04DCdB/CZCNzYgQ2J2bwqnrawGVF61K2Q4=;
        b=j/61OWpKhpk8koV1nHlt7FX8+giE7YkmMuRPqN151Texry0JoBr0sk4bPlPwTEOCyY
         v8wIIlitGPui0XoqjtmY1DQ+GZf+7xCBU96GxooK02MzhtiEztsepvYh/4AdI8j0Iqmw
         W7k15la/6bgdVIB8R8hVJ46sMXRgUhiaJJ96srVD4PeDI1JkCuQSLvMHTPa9NlB05FiB
         BPLYint+BSPaQSezSS8igJKCJkMYl8Wpitpr03yMAZJhrHHcK3NmEK0ygtoxujsjdj5T
         k9oXFaHWLKES4NmApoVQuZjaJkTsUnkdBzvyRQz8PBA97Hh9SLHkOE9PiIJ64LipPzL8
         CClg==
X-Gm-Message-State: AOAM532fAXxSN5B8ShzIkSR2upURpiXBzMafE11W5M+Y9fNTLT1j3tYl
        WU25em9QgZYnnBhc6y46mCMp7JjMIrunNQ==
X-Google-Smtp-Source: ABdhPJx6RC5qksmatktH0S7SWfsZM2VSBXO5EaE8Fxvd6zvnOXXiyhPccS8MA28NTCClSYhGJIGYww==
X-Received: by 2002:a19:593:: with SMTP id 141mr103874lff.144.1602716743020;
        Wed, 14 Oct 2020 16:05:43 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z141sm269031lfc.192.2020.10.14.16.05.42
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 16:05:42 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id h20so1139786lji.9
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 16:05:42 -0700 (PDT)
X-Received: by 2002:a2e:8815:: with SMTP id x21mr173561ljh.312.1602716741597;
 Wed, 14 Oct 2020 16:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201014222650.GA390346@zx2c4.com> <20201014230209.427011-1-Jason@zx2c4.com>
In-Reply-To: <20201014230209.427011-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 16:05:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgDWFJiioE+C=_JOQvEtcw3CVXPq7wDGHDhV8hFrFCnw@mail.gmail.com>
Message-ID: <CAHk-=whgDWFJiioE+C=_JOQvEtcw3CVXPq7wDGHDhV8hFrFCnw@mail.gmail.com>
Subject: Re: [PATCH] powerpc32: don't adjust unmoved stack pointer in
 csum_partial_copy_generic() epilogue
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thanks - applied and pushed out.

             Linus
