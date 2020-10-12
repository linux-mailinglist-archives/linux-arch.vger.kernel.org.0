Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1296F28C170
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 21:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389379AbgJLT0o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 15:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388289AbgJLT0o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 15:26:44 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA0BC0613D0
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 12:26:44 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id f4so13324206qta.12
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 12:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6mP0WzDtsUG1tMreO+ygRTccxYSe5bEz62DcBptZem0=;
        b=MospMFqK9viW/4h5N0M3zamKwAi/hBgz1Ky/5OVOqWMSuSdjKgqs190LOY1ClYLOlP
         thNA6jREhGmMs3Yj5I1NrQfzrBPSpijY0E4mMu1rM2wZKedP5CNorNxCpK/ybXgaGce/
         Po/4XSyR4bmF8MwczBsNPs4pfG4+QMIQZvjiCyy/3ON1lYWJ0oAP4OWM29nLVAkFg9Gc
         /zucgxf6Sdvysi8K3lUt76sh9qUNgtLzMJuYj9W2VrCbiYOy0Ul0ihvRzs8stHvq3kgB
         QLdoyEbRbeu4o9FJiOP03C4IGP/FVUruraGX31mTSVewN+yvZDz5GtnkqER1QIGkinc1
         vy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6mP0WzDtsUG1tMreO+ygRTccxYSe5bEz62DcBptZem0=;
        b=hzS1YmDPr6HBX+XUdkdbcu2KPxZiswRdymsXu7WCFTqa33SICa7fjiiKgmEr33PDQI
         u7aaaQJ4c0sm2CmDJ97agcwHgCeMg/mSfcOPsO55EWwfhdme7gXYWfDEBiekK38W1Yyt
         BCSHSfQdvEs1jvEoqQn4qMijCDgwgNdi7YttYPTJd38UjcBJd++/6nMyKpf+1b9dXB0A
         /XcRVws00X23HkVbSBUf6Xv86jJUX5n7keuKXVaAqRKrYhQKYl/CY8fxbQjvo2PxQ3GY
         Q82CoqNAiXXx+9nDXtZzoZ9JpzFspSTFi7GypGdAPw26C49SxfDWuF+AWfXom3tB03hp
         CZ5A==
X-Gm-Message-State: AOAM5337j4VlIBN6A91BaeWRzWHc1JysfoBiVeXcCDGXiwn1oflnL0Sb
        Iz3gEh7GGfl+s7W6FB4HPTDyv1hcTbUBJNC9P2o=
X-Google-Smtp-Source: ABdhPJzO5rgYO7IUVxVdKCLFmtK2xJSlit9snPEbirs1qP+osmOW+Nv8pB+q9bo4QGLyVayUEBfaXYyIDJltFqADB3g=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:43c6:: with SMTP id
 o6mr17448365qvs.35.1602530803332; Mon, 12 Oct 2020 12:26:43 -0700 (PDT)
Date:   Mon, 12 Oct 2020 12:26:37 -0700
In-Reply-To: <20201012141032.6333-1-cai@redhat.com>
Message-Id: <20201012192637.309661-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20201012141032.6333-1-cai@redhat.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: Re: [PATCH -next] arm64: Fix redefinition of init_new_context()
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     cai@redhat.com
Cc:     arnd@arndb.de, catalin.marinas@arm.com, jean-philippe@linaro.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        npiggin@gmail.com, sfr@canb.auug.org.au, will@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Our CI went red for -next on arm64 due to c870baeede75. Thanks for sending a
fix.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

https://lore.kernel.org/linux-next/20201012141032.6333-1-cai@redhat.com/
