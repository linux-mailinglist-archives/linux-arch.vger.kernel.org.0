Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D853B110B
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 02:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFWAYC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 20:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFWAX7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 20:23:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D6EC061574
        for <linux-arch@vger.kernel.org>; Tue, 22 Jun 2021 17:21:43 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id t32so887246pfg.2
        for <linux-arch@vger.kernel.org>; Tue, 22 Jun 2021 17:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bcpFSddWrPJ8W2Ub9oAqINluFXniubX2BEcya4POfK0=;
        b=gwBNeemJ5unhLEX+su0amWIFj9gAuivmQkyRdhLSVdn7mOpedbuU9suRoeDTbHP6Sw
         2o4aAmEQGzGyzh6dgeeKuVoJ/dcSBTRgpQWYmvLEA6WrQwVjnaxRYdM0QVrv49e8BkIm
         RUTVq4SCvjX+dHU1G9vheOoC+7Sjq7HPl+LTV6oX07oC5rjOXDrq0LB3V9rQVUjPReUN
         gbWRhJKznlKfVsonI7xnCBeTvm1LPOGc1EeUiakyQadpUvCETQCD4TtnjUW3S6fv902J
         q11Hg7hwHfIikq06WmCxf+KYppmoag7Ogof8Z6j1489hE6Soa52gcAVUrkWgB3YfOwKM
         C8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bcpFSddWrPJ8W2Ub9oAqINluFXniubX2BEcya4POfK0=;
        b=I2LFI37W6aCeyHyE8TuKz/11N8ICsMXx3sJX7W3aUABf5g1IA0F0dScpO9fyfUUgmY
         ubhDTnt7iS2d5E1J0cWJ42S/7AD2SZCYZGGlncy/Oep2L1djdGOShLTNCdHn1lwmmXtn
         fj+zlpnpSfC+dMvL935a37V9At33BFyLxRx7iqQCFi+mNOiOLaOZ4UEp7p0qbiXi9eR9
         0PGQzvoU1R6G24el1JJhngA6xggzA+oVvt1kIiQST/KqDccXLM1/3/Y19eHmcd/z5gjQ
         ohHvZVmdH60Im7wkk3QeblCd2CUAOOfEoUBhIBSlkjpJd9ThfjdkszbXrBLv7rHwbn4Y
         kfug==
X-Gm-Message-State: AOAM532YFbZ6J/WE9fpFBkenq0aBb4x7WBDz+Dl5zKEVKtm/JtzRxWvH
        vxuZ0x86nRYixJnoyjgfBlI=
X-Google-Smtp-Source: ABdhPJxfZzuKldyvpa4kU6lsJEvzGiSk/v0sOcODc77n3F5Kx2fnf3bGfzoDYoam0JBEdNlktunW2Q==
X-Received: by 2002:a63:4002:: with SMTP id n2mr1192108pga.124.1624407703055;
        Tue, 22 Jun 2021 17:21:43 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id f17sm20768764pgm.37.2021.06.22.17.21.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jun 2021 17:21:42 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 84C4C3603D8; Wed, 23 Jun 2021 12:21:38 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Cc:     ebiederm@xmission.com, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
Subject: [PATCH v4 0/3] m68k: Improved switch stack handling
Date:   Wed, 23 Jun 2021 12:21:33 +1200
Message-Id: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

m68k version of Eric's patch series 'alpha/ptrace: Improved
switch_stack handling'.

Registers d6, d7, a3-a6 are not saved on the stack by default
on every syscall entry by the m68k kernel. A separate switch
stack frame is pushed to save those registers as needed.
This leaves the majority of syscalls with only a subset of
registers on the stack, and access to unsaved registers in
those would expose or modify random stack addresses.  

Patch 1 and 2 add a switch stack for all syscalls that were
found to need one to allow ptrace access to all registers
outside of syscall entry/exit tracing, as well as kernel
worker threads. This ought to protect against accidents.

Patch 3 adds safety checks and debug output to m68k get_reg()
and put_reg() functions. Any unsafe register access during
process tracing will be prevented and reported. 

Suggestions for optimizations or improvements welcome!

Cheers,

   Michael
   
Link: https://lore.kernel.org/r/<87pmwlek8d.fsf_-_@disp2133>  


