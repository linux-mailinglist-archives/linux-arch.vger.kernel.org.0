Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3EF03141B
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 19:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEaRq5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 13:46:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41921 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfEaRq5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 13:46:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so6634522pfq.8
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 10:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eventslistsusa-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language
         :disposition-notification-to;
        bh=f5E8JLd9OTZ7EMKZ/TJLys/xznOt3ZwyW1UntAKzgj4=;
        b=POEtiYrfHOrbigi7D5YwmU7HuElDsa4Is91OzUaWmSi2t9CP6ToV/4e60XHiMK0i4S
         xkvhUhKhmWFlCNAMkl8+YG8lafnMDMRoYQivZ5o8ebnBKcvF9nccMEAcR8Yeuu/Fe1Dz
         IwN+ILTSZP/SnOC2lwpyjnxAo+EzmmRm0evyLKtEviAyqBueALAASWSuawxcWQSEJA/P
         +TsV6dCoHk2zVV90dNCQ8QhzlDrvb2mWqpS+4TOCxO8HzUNRwKCF9QW5PHrsqcedQyZs
         wMeDxEQTkux8ICq40Fx0Jpr3ig5a84uQUtAgh5ORM//v0U4TrZO8fYa4gZlanAGVPsJp
         ilYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language:disposition-notification-to;
        bh=f5E8JLd9OTZ7EMKZ/TJLys/xznOt3ZwyW1UntAKzgj4=;
        b=BL3ex3/JxokAmlQhuc54jK+cGjbSfi7WY8Ld5mdSkuedwWTzPONCuGIcleXcHp/uNb
         EA5sg9uwSMHTqDiGFvzWDuoTjwZFQgFlUpK2b0y+7nWV3qikl18rgKt0cNxYpRi+YBxQ
         YG+lOf6H3sN/KbwkdNwy15N+9+DZEpPuc5KwRTceEP2/32Swn5iJ2kOCEbpMW9iKWU+h
         2Rt3hr2Ajul+EmUVFyH6hbzdDBkhzwyTZL2iT0w8xMcTQamGXf4sWkawDMQJoNblve8/
         KVTSlIUiuZQ/FTHyCa6O8LJJkj7n2CRYySggpxK6voURUnTR4CSTzXgZBNWKiDXNX0HO
         npuQ==
X-Gm-Message-State: APjAAAUfdVKAdPnbbSU6NIMG1ZTHBCmvbuuCRCo7UceznAS0IwOe9ZoE
        Zatw2xx6OQqyK2V7h3fRGZJS6rpmgTE=
X-Google-Smtp-Source: APXvYqz5v2Jdn3Ndb2Nbt22Q80v9COjXAA/tSPQyHxClx+eTrMGWu7Jg9aRskV+jaiqKpjOeTGFJNQ==
X-Received: by 2002:a17:90a:af8e:: with SMTP id w14mr11140820pjq.89.1559324816125;
        Fri, 31 May 2019 10:46:56 -0700 (PDT)
Received: from adminPC ([49.207.51.185])
        by smtp.gmail.com with ESMTPSA id g9sm5377363pgs.78.2019.05.31.10.46.54
        for <linux-arch@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 May 2019 10:46:55 -0700 (PDT)
From:   jannet.rodriguez@eventslistsusa.com
X-Google-Original-From: <Jannet.Rodriguez@eventslistsusa.com>
To:     <linux-arch@vger.kernel.org>
References: 
In-Reply-To: 
Subject: RE: Attendees Data Base of DAC 2019
Date:   Fri, 31 May 2019 12:46:24 -0500
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAACrx6WBC74lMogpmQeYxQsbCgAAAEAAAADAYfYsJmctFlNmtLQB2SlUBAAAAAA==@eventslistsusa.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdUXCM8Zq6op6MI2TiShA8bnR+mBZAAAO/MgAAAAFKAAAAAEQAAAAASgAAAABAAAAAAEQAAAAASgAAAABAAAAAAEYAAAAATQAAAABTAAAAAEkAAAAATwAAAABGAAAAAEwAAAAAUgAAAABJAAAAAEIAAAAASAAAAABfAAM6DJAA==
Content-Language: en-us
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Hello,

I'm writing to follow up on my email. I didn't hear back from you for my
previous email.

If you're still interested, I would highly appreciate if you would share
your thoughts, so that we can assist you best solution along with affordable
cost.

Awaiting Response,
Jannet


_____________________________________________
From: Jannet.Rodriguez@eventslistsusa.com
[mailto:Jannet.Rodriguez@eventslistsusa.com] 
Sent: Thursday, May 30, 2019 1:08 PM
To: 'linux-arch@vger.kernel.org'
Subject: Attendees Data Base of DAC 2019


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


