Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1546619C
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 11:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241409AbhLBKpS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 05:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237400AbhLBKpR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Dec 2021 05:45:17 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6045CC06174A;
        Thu,  2 Dec 2021 02:41:55 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v203so72082212ybe.6;
        Thu, 02 Dec 2021 02:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=m5JL04vDvVP0L5N5migMb6NSCXdPubj2/VKuNaq+XiI=;
        b=eBi3Q4kCb6syXTo3iEwFbwriGPp6GE4eLe85/a3zx0SHECuMRF1m6ce/TvbbrZnma5
         JVfeRXe/Yvo9iFiSdKVd7wClvXppaYYEQIY5+LK0k9bBIWGCzyYm8P5tAPApmk6iHBv8
         c8Px+soczlUiZVsQbHAI7YV/tmcxj5ZWeNonhKpmwi22ICYkpc7mYV13Laestet3Bch8
         z+IKgzyOy3OjcHFAAOAkpqv6E+sK/ZIWLKrdCoOgRaUMWqiVF3CIGXlmzStEYJ1QEUwb
         84GEuNiUuQOx+kSC4oOtSSmuujvvlBGYuWaO/GBMKEyDFB2/IxxMgE/GC+wnIGe7egQx
         Gfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=m5JL04vDvVP0L5N5migMb6NSCXdPubj2/VKuNaq+XiI=;
        b=a64p4xSPtQZfz9mLiqe3PWsaA948x0/CQki9GEtXSb32TDCtO1HuEWvWbc3rdUaHBz
         uEADUrSMLJwx3ccjBXXeCiOkhoN/oh/zpWUD9RsH7+6FpHgZ9yQQGDNtBfghGvrrVlEl
         xy7acU3KzSauZ0PPnxFRuyoQfd6cSowGdfvDRDO6QSOWKDHtEE1XMu6AaSjLgjObyk2V
         fvS9z989PPSdcl8QGW9rCzB7zHUNLkjbeRochKEkUK19AdiM/fE5YSPP8F/FWiM4+zMi
         9K3KJknqBPOyqDXqJN5eHXrqfHY/oP8sVQTFHgXZZ1EngjEA7HESKQEhSy5NLIZT5Wov
         FDsA==
X-Gm-Message-State: AOAM5332L1/BGVK5ir2eNdbKvcOJo02WnQGNoppFGyD0cykm/Wgg5awQ
        Lw9D+1cZxPjNrCnuWkKsLmvQMcRzzoEqKrscGpc=
X-Google-Smtp-Source: ABdhPJzzC3vpDaSSH8LjbvDWfHzCLmqqlhNKYuUrNvmFM70E+LI/IDssiDqwWYnKRhibt+SgvKEE46XrD4VVyWuzFgk=
X-Received: by 2002:a25:fc24:: with SMTP id v36mr15056218ybd.588.1638441714603;
 Thu, 02 Dec 2021 02:41:54 -0800 (PST)
MIME-Version: 1.0
From:   fei luo <morphyluo@gmail.com>
Date:   Thu, 2 Dec 2021 18:41:43 +0800
Message-ID: <CAMgLiBvwiuG8Awezes8DoBrqP-tk4zHpTdB+gYbBrqkWDmdnEQ@mail.gmail.com>
Subject: [RFD] Clear virtual machine memory when virtual machine is turned off
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

When running the kvm virtual machine in Linux, because the virtual
machine may contain sensitive data, the user may not want this
data to remain in the memory after the virtual machine is turned off.

Although this part of memory will be cleared before being reused by
user-mode programs , But the sensitive data staying in the memory
for a long time will undoubtedly increase the risk of information leakage,
So I wonder whether it is possible to add a flag (like MAP_UNMAPZERO)
to the mmap(2) system call to indicate that the mapped memory needs
to be cleared zero when munmap(2) called or when the program exits.

Of course, the page clear operation not only occurs when munmap(2)
called or program exits, but also needs to consider scenes such as
page migration, swap, balloon etc.

When reusing the page that has been cleared, there is no need to clear it
again, which also speeds up the memory allocation of user-mode programs.

Is this feature feasible?
