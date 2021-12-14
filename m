Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E0A4746CE
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 16:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhLNPuH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 10:50:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230073AbhLNPuH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Dec 2021 10:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639497006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A8d4kpiCPLqH4HU8MweJaovj1iydZX/tfYgtR0hH+gc=;
        b=b+2lfGuBuAt21be04ez+kyRKUmHYKqPh+orKreq1wbzxdpR7DWizgTCZZ+9Hlog40TJdAA
        gvofemXyvsxLEg574IDXvClANyAEu+BOT+cZbdrepm5pZpf+GSXAB7BvDsk428xFwk/Jxh
        PEQe+9JpOCeyQ3Hl+Ij053I4e/GcTd4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-YoMUXnhbMteNK6Lj4dy4yw-1; Tue, 14 Dec 2021 10:50:05 -0500
X-MC-Unique: YoMUXnhbMteNK6Lj4dy4yw-1
Received: by mail-oo1-f69.google.com with SMTP id g1-20020a4ab801000000b002c63cddd8f6so13035925oop.5
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 07:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A8d4kpiCPLqH4HU8MweJaovj1iydZX/tfYgtR0hH+gc=;
        b=rpCY+28M9ALIyUiI+tQE+Pumk64a4d35k4XhprzGwNefemYGTGo+87vJGPfsO+X5es
         zKO4hHkcYD0w+TUCvGDRxamGfNreC6xWnSHf/QY3tNDuxAncCtlFPpta+ejwU1ZnXP5l
         g0W1FKz2sktgAwV5uSF3IIocOoxqqWdfAguR1nYYaEqFxZtfNmtURYfHxxp9ViwaMgC9
         2VjbK6Exopq+xGEEcBgKWZjujM3ZS70HFHDk8aEAmqSZoCXIkl8SqAyGUCbM7Mq1BvPX
         IlwMTdcClMIV5C5aOt88WivXtZ/g4Pdk5Tktys0+ZiFvUs2eNB4o2ylqI4neY9aaTP6D
         6bPg==
X-Gm-Message-State: AOAM5303SykuQLiERvQydViCPp2IQEowYZiQDDlYb/iFfhQR1hXHLPd2
        V/NA8fgGTtNsHTFpv5hUEVoF9reum56SutuEAhUEYbjqTu94zVgLfli4vIDnLs/TYeRbCsxlMnp
        wuJ/h3ryUfSqlXXiEqq3wxQ==
X-Received: by 2002:a4a:ead8:: with SMTP id s24mr3900085ooh.89.1639497004330;
        Tue, 14 Dec 2021 07:50:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXgBh0sUNBMdxzkV5fM6eNiIi7SMjd8NeymgTWllADHqHZP9MNB6Lack/Qn0/mfPxnhLJZAw==
X-Received: by 2002:a4a:ead8:: with SMTP id s24mr3900068ooh.89.1639497004102;
        Tue, 14 Dec 2021 07:50:04 -0800 (PST)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id bc7sm43620oob.35.2021.12.14.07.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 07:50:03 -0800 (PST)
From:   trix@redhat.com
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] locks: cleanup double word in comment
Date:   Tue, 14 Dec 2021 07:49:41 -0800
Message-Id: <20211214154941.2463357-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tom Rix <trix@redhat.com>

There are two the's in the comment, remove one.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/uapi/asm-generic/fcntl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index ecd0f5bdfc1d6..d08406ea25fe5 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -143,7 +143,7 @@
  * record  locks, but are "owned" by the open file description, not the
  * process. This means that they are inherited across fork() like BSD (flock)
  * locks, and they are only released automatically when the last reference to
- * the the open file against which they were acquired is put.
+ * the open file against which they were acquired is put.
  */
 #define F_OFD_GETLK	36
 #define F_OFD_SETLK	37
-- 
2.26.3

