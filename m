Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790F268C04D
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 15:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjBFOjA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 09:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjBFOi7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 09:38:59 -0500
Received: from sp13.canonet.ne.jp (sp13.canonet.ne.jp [210.134.168.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 111D91ABEB;
        Mon,  6 Feb 2023 06:38:57 -0800 (PST)
Received: from csp13.canonet.ne.jp (unknown [172.21.160.133])
        by sp13.canonet.ne.jp (Postfix) with ESMTP id 54BCC1E04A4;
        Mon,  6 Feb 2023 23:38:54 +0900 (JST)
Received: from echeck13.canonet.ne.jp ([172.21.160.123])
        by csp3 with ESMTP
        id P2dyp0UAFxJr5P2dypjD2X; Mon, 06 Feb 2023 23:38:54 +0900
X-CNT-CMCheck-Reason: "undefined", "v=2.4 cv=S49nfKgP c=1 sm=1 tr=0
 ts=63e110fe cx=g_jp:t_eml p=ISLhRirdagkA:10 a=c8wCX2VJ6RehaN9m5YqYzw==:117
 a=yr9NA9NbXb0B05yJHQEWeQ==:17 a=PlGk70OYzacA:10 a=kj9zAlcOel0A:10
 a=m04uMKEZRckA:10 a=x7bEGLp0ZPQA:10 a=HfeQpGcjZfE_bzzYnMgA:9
 a=CjuIK1q_8ugA:10"
X-CNT-CMCheck-Score: 100.00
Received: from echeck13.canonet.ne.jp (localhost [127.0.0.1])
        by esets.canonet.ne.jp (Postfix) with ESMTP id 111BB1C0250;
        Mon,  6 Feb 2023 23:38:54 +0900 (JST)
X-Virus-Scanner: This message was checked by ESET Mail Security
        for Linux/BSD. For more information on ESET Mail Security,
        please, visit our website: http://www.eset.com/.
Received: from smtp13.canonet.ne.jp (unknown [172.21.160.103])
        by echeck13.canonet.ne.jp (Postfix) with ESMTP id B7D411C026C;
        Mon,  6 Feb 2023 23:38:53 +0900 (JST)
Received: from satutoku.jp (webmail.canonet.ne.jp [210.134.169.250])
        by smtp13.canonet.ne.jp (Postfix) with ESMTPA id 9122F15F962;
        Mon,  6 Feb 2023 23:38:52 +0900 (JST)
MIME-Version: 1.0
Message-ID: <20230206143852.000070AE.0060@satutoku.jp>
Date:   Mon, 06 Feb 2023 23:38:52 +0900
From:   "Chaoxiang Genghis" <iren@satutoku.jp>
To:     <cgcgcg@cg.ch>
Reply-To: <c-genghis0@yandex.com>
Subject: Hi Greetings...,   
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Priority: 3
ORGANIZATION: banking
X-MAILER: Active! mail
X-EsetResult: clean, %VIRUSNAME%
X-ESET-AS: R=SPAM;S=100;OP=CALC;TIME=1675694334;VERSION=7944;MC=3594318919;TRN=15;CRV=0;IPC=210.134.169.250;SP=4;SIPS=1;PI=5;F=0
X-I-ESET-AS: RN=442,624:0;RNP=c-genghis0@yandex.com
X-ESET-Antispam: SPAM
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,UNRESOLVED_TEMPLATE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [c-genghis0[at]yandex.com]
        *  1.3 UNRESOLVED_TEMPLATE Headers contain an unresolved template
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [210.134.168.90 listed in bl.score.senderscore.com]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [210.134.168.90 listed in wl.mailspike.net]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Hi Greetings...,   

How are you doing today, I hope this email finds you in good health. You have not responded to my previous emails to you regarding Mr. Husson. 

Kindly acknowledge my proposal and let me know what your decisions are, if you are taking the offer. 

Get back to me as soon as you can for further details. 

Best regards,
Mr. Chaoxiang Genghis.


