Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A028F17D
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 13:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgJOLog (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Oct 2020 07:44:36 -0400
Received: from mail.csu.ru ([195.54.14.68]:52936 "HELO mail.csu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729969AbgJOLob (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Oct 2020 07:44:31 -0400
Received: from webmail.csu.ru (webmail.csu.ru [195.54.14.80])
        (Authenticated sender: gmu)
        by mail.csu.ru (Postfix) with ESMTPA id 9ABA11425E0;
        Thu, 15 Oct 2020 16:34:31 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.csu.ru 9ABA11425E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=csu.ru; s=lso;
        t=1602761688; bh=3a87bqEECgzQlmJ1wGXY5qdbrcBb1wrajgfr+n2VLzw=;
        h=Date:Subject:From:Reply-To:From;
        b=MBe0GH8m1xoALcZJJo+tEkH8DT+8jm67s7BKrNaAnYSZz9bWWB6M7uNuo79NOe0Qb
         51i4TfroGUYt10e38dkx0uBjNl7Y1HnIhhqK10RGGes/M6Nd3v1eMiIAx/4Y9H962E
         kVPcwDvAUZIk8YaDkIjEFOvXd5SMMGrJIrwV4XEM=
Received: from 156.146.59.30
        (SquirrelMail authenticated user gmu)
        by webmail.csu.ru with HTTP;
        Thu, 15 Oct 2020 16:34:36 +0500
Message-ID: <e17e1f98affc371e2348410ac75d035e.squirrel@webmail.csu.ru>
Date:   Thu, 15 Oct 2020 16:34:36 +0500
Subject: Vorschlag
From:   "Yi Huiman" <info@csu.ru>
Reply-To: info@huiman.cf
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
X-Priority: 3 (Normal)
Importance: Normal
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 159201 [Oct 15 2020]
X-KLMS-AntiSpam-Version: 5.9.16.0
X-KLMS-AntiSpam-Envelope-From: info@csu.ru
X-KLMS-AntiSpam-Auth: dmarc=none header.from=csu.ru;spf=softfail smtp.mailfrom=csu.ru;dkim=none
X-KLMS-AntiSpam-Rate: 70
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 381 381 faef97d3f9d8f5dd6a9feadc50ba5b34b9486c58, {rep_avail}, {Tracking_content_type, plain}, {Prob_reply_not_match_from}, {Prob_to_header_missing}, {Prob_Reply_to_without_To}, {Tracking_susp_macro_from_formal}, huiman.cf:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;csu.ru:7.1.1;webmail.csu.ru:7.1.1;195.54.14.80:7.1.2, ApMailHostAddress: 195.54.14.80
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2020/10/15 10:36:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2020/10/15 07:09:00 #15491089
X-KLMS-AntiVirus-Status: Clean, skipped
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ich habe ein Gesch=C3=A4ft Vorschlag f=C3=BCr dich.


