Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB4310328
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 04:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhBEDJN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 22:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhBEDJH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 22:09:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F553C061786;
        Thu,  4 Feb 2021 19:08:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c12so5962722wrc.7;
        Thu, 04 Feb 2021 19:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=hqf55dXwvcYwwL4sAkoYuOM6RPu6wxeec88n5sMRYiY=;
        b=Eti10+JFGOol8jfOa14o47a/rpSAorKcSZ0ncPqyw/9cX0DR0jaUWy3HHGbGUhwsnC
         VFuwhbPOIBVrJrFHpCZDCZG4vabnvZdlBNv5AjO+bq+ihNBfTeNOxavFjcJeCpE9wN+T
         jLQiM089Oqb8NlWXCWY6TjPwFcAPUlRGNcGxE3FcGF+ceJIN+ZQ0hbcDvUS5EbrY6x3I
         x9M7GzV17ocILyG3UYVmSBxDi2zXXb64pPDSLip+jaVHP06GZzDmbbW2EjmMvhhOLME2
         lintPMJTlsNvzqjtSuEV8JAMdvS+9A5kt9yYq7umOz/Mou8Xk3B7SwtlAEmG0xAjhZun
         JggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=hqf55dXwvcYwwL4sAkoYuOM6RPu6wxeec88n5sMRYiY=;
        b=NVo3risIIK0+MV0jqksFi+V1uAgTEAPVFgKlWHFfOxMNbi14IVhylqNlKAjJy0XDfK
         FxCwQFoTp+cdv/lsz3L4YRw0U6SKJiTTarFgqol+8Cp0OKdy+0axVcIOrrE1NAWSBaIy
         AX08McBHUDPLjE9JA4qIk6ZXBCwRpxjftVL1P6nfkWsGOZ0tWKEQnsLKMhLWIV2Cepm/
         G0J+oNkPj1znxIM90s8jRWz8kpR3LAKtXV5fUBhH7HWTC3kdsj55PfOpaipQwneGw7uM
         Cl+Nnue7s3+YGSOEdKVqlRkaYqyMOg8+dDeuxj8NeWiSmJHXF7De88SEEW+VnVUmYGA+
         zYdg==
X-Gm-Message-State: AOAM531uMe2U6lUKQB3QqE4wsGpl2AvBsXD0NECn7hj5f7Mwf2OMQMaL
        htyGnEoMvJRnLIySpaWRzW7xKFzV2PEkag==
X-Google-Smtp-Source: ABdhPJzCLixohysxQzqUyd290R0CNpRU05l+zBb4lSCQmopswAm1/zYVCjd0eRxXi50uofjGxjJEfg==
X-Received: by 2002:a05:6000:1364:: with SMTP id q4mr2459978wrz.335.1612494504125;
        Thu, 04 Feb 2021 19:08:24 -0800 (PST)
Received: from [192.168.1.6] ([154.124.28.35])
        by smtp.gmail.com with ESMTPSA id n9sm10836813wrq.41.2021.02.04.19.08.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2021 19:08:23 -0800 (PST)
Message-ID: <601cb6a7.1c69fb81.5ea54.2ea6@mx.google.com>
Sender: Skylar Anderson <barr.markimmbayie@gmail.com>
From:   calantha camara <sgt.andersonskylar0@gmail.com>
X-Google-Original-From: calantha camara
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: hi dear
To:     Recipients <calantha@vger.kernel.org>
Date:   Fri, 05 Feb 2021 03:08:08 +0000
Reply-To: calanthac20@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

do you speak Eglish
