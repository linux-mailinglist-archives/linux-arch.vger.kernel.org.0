Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB26D204353
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 00:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbgFVWJU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 18:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgFVWJU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 18:09:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0291AC061795
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:09:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z63so9057659pfb.1
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/CEH8VTZP2jm3BrV0iJu7stxsX/cPaPfhD00FUDCJv4=;
        b=bRwAtSDcvMoGuvZ2V7MiZQ2AYZUB+iIZ05GyxDgMaBYPPQr/eNqeta8s9Kj+A1e/w1
         UIeNztzPOl4SqKZrPezEvOsyvcurMrLEI/peVpvJ/dmpiL64RCNMDJXaiKzazq8CIRWm
         Dh5pvxamRTWNQzWILwK3KtEIgH+FDxrwMANd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/CEH8VTZP2jm3BrV0iJu7stxsX/cPaPfhD00FUDCJv4=;
        b=uCNkTuh98/MePxmnluEhpIfULpCpm5zBLpApn6275fGpDw7eGpe3jZKETa3VncDx+o
         WMLSLeqmVSnc9HcS+UKtKMn3c4uF0ToWWtZIVinz/C4BMTcwb7wgLM/v3Fa7bXxf33r6
         Z05bKCxsDzOIG0kK/1HEfCe9qN1WJXx8vheVce0YjrvK4haerRTDg29Q/139ex+7D7IA
         MT6ONTaPAsu9h7SBCewDJo8sggtKCm7nrUF1L4IGOB+cyuyvFUuvNoIzVtTHwQzN6umO
         pwgG6lqXtNOxAv1qoEjzt2fSdD8Efxm7whXX0KsuJ5p+J/HuasWCVU/EvJumB4McVQEj
         7Q9A==
X-Gm-Message-State: AOAM533J/JkQjW4BHvMkCiGpE4dCuCdr4THRqEnYvxWs2YqZgN7OC6Go
        zCeSTehwQNzE1FVL9rhz0/9lsA==
X-Google-Smtp-Source: ABdhPJykHm2jiXE5Pmhx3etgyY6WR3nAeR8QFSIhZb8Lz+hGyZ6oJNwV16mTngn4VvoaSoaecDuRBA==
X-Received: by 2002:a63:181f:: with SMTP id y31mr14845560pgl.47.1592863759529;
        Mon, 22 Jun 2020 15:09:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cm13sm454470pjb.5.2020.06.22.15.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:09:18 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:09:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Message-ID: <202006221508.F3A8D3B9@keescook>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org>
 <20200622220043.6j3vl6v7udmk2ppp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622220043.6j3vl6v7udmk2ppp@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 22, 2020 at 03:00:43PM -0700, Fangrui Song wrote:
> On 2020-06-22, Kees Cook wrote:
> > For vmlinux linking, no architecture uses the .gnu.version* section,
> > so remove it via the common DISCARDS macro in preparation for adding
> > --orphan-handling=warn more widely.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > include/asm-generic/vmlinux.lds.h | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index db600ef218d7..6fbe9ed10cdb 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -934,6 +934,7 @@
> > 	*(.discard)							\
> > 	*(.discard.*)							\
> > 	*(.modinfo)							\
> > +	*(.gnu.version*)						\
> > 	}
> > 
> > /**
> > -- 
> > 2.25.1
> 
> I wonder what lead to .gnu.version{,_d,_r} sections in the kernel.

Here's where I see it:

ld: warning: orphan section `.gnu.version_d' from `arch/x86/boot/compressed/kernel_info.o' being placed in section `.gnu.version_d'

-- 
Kees Cook
