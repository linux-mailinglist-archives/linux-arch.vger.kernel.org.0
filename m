Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22CE359280
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 05:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhDIDIr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 23:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbhDIDIo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2021 23:08:44 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAD9C061762
        for <linux-arch@vger.kernel.org>; Thu,  8 Apr 2021 20:08:32 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q10so2820527pgj.2
        for <linux-arch@vger.kernel.org>; Thu, 08 Apr 2021 20:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VtuEueWcaC1955LnaOVqKunKMhIKwbtn+Mdlogx6zxA=;
        b=EqcbqDa8gNnAl2FpALvPwEaZBOSBw3B00uafrozwofFF7zUxWJPEcj4EwCeolZfrU6
         pngVNlHOvWEyWAQRDO7Y3rMNpkJSqeMPSXNm/O3SiYqqARSgr9qf4uvC1rL4uLa/Tbs4
         Hi3r+041t58NT5ggp4N4WWvytcyhpngZqhKdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VtuEueWcaC1955LnaOVqKunKMhIKwbtn+Mdlogx6zxA=;
        b=V+xCJN1P8TEXBrR7tZ8+hy5IaNAghyd1irPieQX42OeEtwSwNpuQt7AwYf2cpNf9b+
         uxhjmuc68+Prbsn3dAXcXla18dIw80yVwx9bwq6c2Dp6lKuHRAkLU19aL2ZAmwDxyR31
         0EvNwvVYGAwQ3AWolAPh8mbpfvqNXta4kQEpGQsHeqDYoPLAib9TVfiGnxjht+o6vaiA
         8QvLrOKRr5ocw+CC74aXTA2xxTGzTMRaAcNIcbTSgwWqXT1yzm6Ty7F6apfx/AyvbazZ
         nNnj3noi6X5XgFSAbqrb660MWgS6QOK4tUJ3e+3UvVGiWUz+WIE+3CoNTtFUqWF5wA29
         wGHQ==
X-Gm-Message-State: AOAM532lz+LG6pt0qhIPclW7fAHlczVY2yWvysNX8QYIIlIYc4QFwyO4
        lfQA6XbWMHe6d/qYRX+BpF9DwQ==
X-Google-Smtp-Source: ABdhPJwesH3bAYyHHBi1JZroy1EOahpCZwAfNZZ8/KQHG8nL5f52UVChwFkDMulHU1F6U8rhq3tPXg==
X-Received: by 2002:a63:485b:: with SMTP id x27mr11211392pgk.0.1617937712141;
        Thu, 08 Apr 2021 20:08:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q19sm641873pgv.38.2021.04.08.20.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:08:31 -0700 (PDT)
Date:   Thu, 8 Apr 2021 20:08:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH 01/20] kbuild: move x86 install script to
 scripts/install.sh
Message-ID: <202104082008.780F179FC@keescook>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407053419.449796-2-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 07:34:00AM +0200, Greg Kroah-Hartman wrote:
> To unify the different architecture kernel installation scripts, start
> out with the one they all were based on, the x86 script.  Move it from
> arch/x86/boot/ into scripts/ so that all architectures can call it in
> the future.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
