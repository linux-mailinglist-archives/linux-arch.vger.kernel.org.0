Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3DE30087
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2019 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfE3RIX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 May 2019 13:08:23 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:36467 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3RIX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 May 2019 13:08:23 -0400
Received: by mail-pl1-f173.google.com with SMTP id d21so2825581plr.3
        for <linux-arch@vger.kernel.org>; Thu, 30 May 2019 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eventslistsusa-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=81s8cgRViDKw2MFUInyID8Cyko4TmBhI3j3x7e8xmNQ=;
        b=z4lDulne9amoi0Sc9bnYmypaxJSaA8CJI4Yxm109JTDcqCtmCiIhU7ipspMtDNCCBb
         3Isdmee8ZTRJnw5+0WqSXUYiMYct0NA73EyPrUPVr7REYRrEOb+mVMC7zTYODWVSXWJQ
         kZzsA1vn2Ij8xbyT2SygBqdp+Du/ck1qseGF9Re7ERuj9aMO3HJWfNyWwT8cw6+Ljd+v
         9CDcLVMp2rVHfpAd63IROMdC6gKrDCwGAThifZgFteL06juG7r4umtnzV+SAFhKy4BjA
         De3PGJqxi2hbvRdzsRMdCXVgwo6k4qwMCmN57R+Wg0LvCDmdgFJQJdMxyEozCqot3bkl
         IDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=81s8cgRViDKw2MFUInyID8Cyko4TmBhI3j3x7e8xmNQ=;
        b=Clfzf+Sbjv+MYaqeodUA5pQVQwUNrkjucfMRVRjD7YcFn+h3TcWXEmKOsCtxjhHWYL
         TC4uWMTCQsJ+FzAfBSLGFLJ+BRGgVCQqG5zPh65FlrEcz8Qh2kh7AuZ1RxQbirK/GF54
         /gpc7WULaCOxKY2caqxpwx4sdX5errBGdFD/HAxeqo2oRQAPDfQuFHMb2ozR8G9JCVps
         iBB0/VURkR/t/onw4b1FC7FBmoX86ECipeva8oI7vt+EAcEx2jmmq0+e5FGD5LzolKY0
         /mrNK8MzTXooNWAooppjdoWeo9B5TF5rAROfbglSi8a0GuUQjG5kbp4u1zZC27UTO0VN
         oAQw==
X-Gm-Message-State: APjAAAUIw/+QH3vpm3sSDuX8eQFj5DyEsZJoxtM3cRa3yVSQ5P28iI/S
        3BK6ILoh66JqbmpwjmQ3lk0dwgkjmB8=
X-Google-Smtp-Source: APXvYqwBqiVKfywLtuD4bNhbd/f4oAXeaiyx32w8w5gM5l5f/ZMEwL/kaRQbQC7KQPchsEyy0H7rXg==
X-Received: by 2002:a17:902:9b94:: with SMTP id y20mr4731039plp.132.1559236102501;
        Thu, 30 May 2019 10:08:22 -0700 (PDT)
Received: from adminPC ([27.7.15.150])
        by smtp.gmail.com with ESMTPSA id q7sm3368435pjb.0.2019.05.30.10.08.20
        for <linux-arch@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 May 2019 10:08:21 -0700 (PDT)
From:   jannet.rodriguez@eventslistsusa.com
X-Google-Original-From: <Jannet.Rodriguez@eventslistsusa.com>
To:     <linux-arch@vger.kernel.org>
References: 
In-Reply-To: 
Subject: Attendees Data Base of DAC 2019
Date:   Thu, 30 May 2019 12:07:43 -0500
Message-ID: <323701d5170a$4875d010$d9617030$@eventslistsusa.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdUXCM8Zq6op6MI2TiShA8bnR+mBZAAAO/MgAAAAFKAAAAAEQAAAAASgAAAABAAAAAAEQAAAAASgAAAABAAAAAAEYAAAAATQAAAABTAAAAAEkAAAAATwAAAABGAAAAAEwAAAAAUgAAAABJAAAAAEIAAAAASAAAAABfA=
Content-Language: en-us
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,
I am following up to check if you are interested in acquiring Design
Automation Conference & Exhibition 2019
Let me know if you would like to acquire Attendees Data Base?

Attendees List:  Designers, Researchers, Tool developers, Vendors And Many
More...
Each record in the data base contains: - Contact Name, Job Title,
Company/Business Name, Email, Tel Number, Website/URL etc.	
If you are interested, please let me know your thoughts, so that I can send
you the no of contacts available and the pricing for it.
Awaiting Your Reply
Thanks & Regards,
Jannet Rodriguez
Marketing Executive


