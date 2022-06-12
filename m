Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FD6547D03
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 02:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbiFMADd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sun, 12 Jun 2022 20:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiFMADc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jun 2022 20:03:32 -0400
X-Greylist: delayed 523 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Jun 2022 17:03:30 PDT
Received: from bufferz9.csloxinfo.com (bufferz.csloxinfo.com [203.146.237.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABB9917A82;
        Sun, 12 Jun 2022 17:03:30 -0700 (PDT)
Received: from mailx1-13.cslox.com (unknown [10.20.140.13])
        by bufferz9.csloxinfo.com (Postfix) with ESMTP id 0449E2367ED5;
        Mon, 13 Jun 2022 06:54:46 +0700 (ICT)
IronPort-SDR: LjtQRjqGfK/yfjuYr7xgQBsEWCqtvKMNOZFGA/sohIUEsmybDsRFHzQh13/Z5SjGs1DEsolBkh
 0XC7L4aJbf7UVRbCvgE2+cGnfHouxIx+U=
IronPort-Data: =?us-ascii?q?A9a23=3AQ0rSFKrnUD+pURXIgO83qiOxvideBmJfYRIvg?=
 =?us-ascii?q?KrLsJaIsI4StFCztgarIBmAOKmCNGH2L4x2a4vi8kIAvZSBzIdiSwNurHxgQ?=
 =?us-ascii?q?SpG9ePIVI+TRqvS04F+DeWdFhM+s5hAAjX4wUldokb0/n9B65Dt8itx07+mX?=
 =?us-ascii?q?L35BLKWMyx9X1Y8Gj0shRNllKgyhYsx2Yq1BAaEuNXTpczDOQ/5gmYvaDpMs?=
 =?us-ascii?q?6/T+glyuPnSuS8DugBsb/58o1KDxWIeC4gSJP/tIiKgEJVUBOOzW83K0Kq9o?=
 =?us-ascii?q?jHC5x4oB978yuT7f0QGT6T8Jw+LjnYKCaGujgIb/n4o36o6MvVaYkBS0m3bk?=
 =?us-ascii?q?9d0wdRLlJqxVQZ5YvSUw75FC0FVSngsM7dH9bnLJWmEnfaSl0CWIWHxx/hOD?=
 =?us-ascii?q?V0tOdFK8OhAHmwTp+cTLyoAb07firvukq67UORlmu8qMNLvYNEEonhlwDzUV?=
 =?us-ascii?q?K10QZ3KT6jQ39JA2CYsgcRCQaTXa8YDMGE9YwnDahxKM1YTTpk5mb7w1HX4d?=
 =?us-ascii?q?jRZrnOTpLY2ujaOl1UrjuO1a9eFKMaXQch1n1qDojKU9mv0NQ0XOdqSlGie+?=
 =?us-ascii?q?XW2i+6RwC72Vd5AFLC88fI20lSfynZJU08TXFq/5/ajg0iyVsJUL1EP+zQj6?=
 =?us-ascii?q?6M18RXzHNX6WhS5pl+CvwIdAoAOS7dnsFnQlKeEsRyEAmUkTyJabIB0vsEBQ?=
 =?us-ascii?q?zF3hESCmMnkBGAyvbCYIZ5HGmx4lhvvf3lMRYM+TXVcF1FdvYC5+NtbYi/nF?=
 =?us-ascii?q?76PLobk1rUZJhmtm1hmnABm71kipZZjO5eTpTgrsBr0znT9dTPZ0y2MNo6TA?=
 =?us-ascii?q?qyVU6b+D2CgwQCzAf+tt+91RHHZ1JQPs5D2AOzjkfiweCKxrOUlRNlF5t6AO?=
 =?us-ascii?q?TzYx1F1Fp8t+iSm/2O4fJ5dpjp5IS+FMO5eJnmzPROV4F8PosYMVJepRfcfj?=
 =?us-ascii?q?4aZBNlszqHhPc7oWvHSYZxFZZ0ZmAqvp3o2PBfBhju8+KQrueRlUXuBSu6oD?=
 =?us-ascii?q?HAHGeFu1jG2b/kS3KVtxS0kw27XA5fhwHyP1buYeW7QRKcZbHOQYe0jqqCJu?=
 =?us-ascii?q?gPY95BYLcTi4wtQSuz7bzL/74EdLFYDK3EwBJnysMFNaO+IL0xtH2RJI+PN2?=
 =?us-ascii?q?74nZ4t/t7pal+yO9Xa4MmdZynLhinvKNUOBbXULQLjvVIx7qm4nMGoqOkykw?=
 =?us-ascii?q?GQ5ZoOH8qgFepQ2er9h7+EL5fh9SPwEU9uPGPNBRDXM9nIad5aVhI8keBmkn?=
 =?us-ascii?q?wWJIwK7byN5eZoIbwPN99nMYATw6CQeBzHxvsw7y5Wp0B/cR4EDThtiB9jOQ?=
 =?us-ascii?q?Oyvw1r3tn8Y8MppQlPQJcNPUFvs/pJnICvrguRxKcgKJR7KwyPc3AGTaT8Ro?=
 =?us-ascii?q?e/lvY8xtt/N7YiOtYaBDet6WExed0HX5KieKyneuGynqadMUc6WfTSbUmec0?=
 =?us-ascii?q?Kq4as1Lz/W6NvlvtFlam5R8F/BtycoW59LHub9eiAJgdF3IdEiDFLNkZH+Ct?=
 =?us-ascii?q?eFIsLdl2L9d/w2yMmqU/9RyJ7WNfsXheHYNPgMNcOSHk/cQ8hHM4PIdPkX+o?=
 =?us-ascii?q?ilzlJKZVUh6IRmIzipZRJNrK5kN3+cl/sgSgySgjxMCLNaCyCZQn0yNKHIHe?=
 =?us-ascii?q?7snsowcAZHmkBEq1kAEapvZYgfz6ZCLQ8tMN0gsLj6dwqHFgtx0ykPEW2QzD?=
 =?us-ascii?q?nbJm+FagPwmpBlD0F4BKlfQy/LbhuQxzRYX9i44JixUyBtA+/xyYHZqcUF4T?=
 =?us-ascii?q?Y2A9i1tjdFrQWGlXhtaQhuU5iTZz1oPmGSfUUizTWHXBHM8MKOT/VsC/ngae?=
 =?us-ascii?q?Dwz1LacyXjkWB70fciuhSUzXUt+7ffkSLRZ6AzEk82hA4KJH5Q8ZzvjqrGvb?=
 =?us-ascii?q?GEFsBqhD9lZrEzBq+5C4ud5YqnyLjUKpKo+EM+R0rF4YBycKm1FW/x6/YsXH?=
 =?us-ascii?q?GjXfzS50yPIIEe0EutPIPrD7U+xDYptJ9hMUx242A6QrzkQAqsHKaQyl/ksj?=
 =?us-ascii?q?PIAa7T3JCgYuqGcoytBrpPZ/S/7j2UwBd5plK4VK4XfcBqcE2WcjH8SnWulh?=
 =?us-ascii?q?MsCP2OifdgCTBP91e2z/f8GBokEtPxwcEY0yf2/uHD9GAph8RW8ogLKaKDXx?=
 =?us-ascii?q?vZ+j49rmuPEEqxFCBq0LdryT8yW8Qm8tNBCK9XCLa/mtQMSrVXPIQVfMqEYV?=
 =?us-ascii?q?dVn07KArLbf2kTDsZ4oUmnWgZCAEadO+cK+VfsROMbwI2JCmjfEU8jpizMA5?=
 =?us-ascii?q?W2iNpFIkvtD58CkAQ28AOO9cdcUXdobz31UZjJXDwocI7r2Z6Lpv2W2qPHKA?=
 =?us-ascii?q?AJ1+QLOJtKu83avYmZeezQgJZz3Dwbu/f2p45ZStuxkDx8FA/1sAoVkIFTkX?=
 =?us-ascii?q?LMvcdz2sxGGD2Cuj0/EsbKKvRkm7iHACnieF+7k4JvDSwS4fx3ahU1i5Lm1q?=
 =?us-ascii?q?KQo4VtNUSo72LVuOBtCk+OaQguSVAYuRdnx+71dYn2MrhHP6Q=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A1EnXp67RfgBIuEA+twPXwNHXdLJyesId70?=
 =?us-ascii?q?hD6qkRc203TiX2raGTdZgguiMc6wx8ZJhDo6HjBEDoexq1nvQZ3WB4B8bGYO?=
 =?us-ascii?q?CMgguVxe9Zg7ff/w=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0D//wCze6Zi/xGS/htaBhYBAQENLwE?=
 =?us-ascii?q?BBAQBAQIBAQcBAQEBAQcBAQkJgT0GAQEDAQGBOAIBAQEBTAgVgRo2KxIYAQG?=
 =?us-ascii?q?NeIYCgzAVAo9wGX+DcYY3gXsLAQEBAQEBAQEBDQ4wBAEBgU0BgyoCCFEBBAa?=
 =?us-ascii?q?EbgElOgQNAQIEAQEBEgEBBQMCAQcEgQkThXVAFgEBDYE9hBxJVg0UMAJQRwe?=
 =?us-ascii?q?CQ0WCUwIBnkCHQodTgTMaAmWEWYNSAYFSgTsCAQEBAQEBhhkVRoJXhUWCKYF?=
 =?us-ascii?q?LgQWBbz6BU4JxhA2CLgSYEQQaOgM0EzQSgSFFLAEIBgYHCgUyBgIMGBQEAhM?=
 =?us-ascii?q?SUx0CEgwKHA5UGQwPAxIDEQEHAgsSCBUsCAMCAwgDAgMuAgMXCQcKAx0IChw?=
 =?us-ascii?q?SEBQCBBMeCwgDGR8sCQIEDgNFCAsKAxEEAxMYCxYIEAQGAwkvDSgLAxQNAQY?=
 =?us-ascii?q?DBgIFBQEDIAMUAwUnBwMhBwsmDQ0EHAcdAwMFJgMCAhsHAgIDAgYXBgICbwo?=
 =?us-ascii?q?mDQgECAQcHSQQBQIHMQUELwIeBAUGEQkCFgIGBAUCBAQWAgISCAIIJxsHFjY?=
 =?us-ascii?q?ZAQVdBgsJIRwJIAsGBQYWAyNzBUgPKTU2PC8hGwpPKAFZD50FknghgTmOBmC?=
 =?us-ascii?q?CFJwnBwODTol8lXwaMRiDSwERjD+GGw4IFgMXkUeWa6F4hhlhPAcbgVlwgW4?=
 =?us-ascii?q?KJYEcUBmPAI4MNG8CBgsBAQMJjSYwg1MBAQ?=
Spam_Positive: LL
X-IronPort-AV: E=Sophos;i="5.91,296,1647277200"; 
   d="scan'208";a="330119139"
Received: from unknown (HELO mail.grandexclusive.com) ([27.254.146.17])
  by mail-1.csloxinfo.com with ESMTP; 13 Jun 2022 06:54:45 +0700
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.grandexclusive.com (Postfix) with ESMTP id AE3E6284449;
        Sun, 12 Jun 2022 17:58:47 +0700 (+07)
Received: from mail.grandexclusive.com ([127.0.0.1])
        by localhost (mail.grandexclusive.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DdBbHwDzpKPR; Sun, 12 Jun 2022 17:58:47 +0700 (+07)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.grandexclusive.com (Postfix) with ESMTP id CA306284442;
        Sun, 12 Jun 2022 17:58:46 +0700 (+07)
X-Virus-Scanned: amavisd-new at grandexclusive.com
Received: from mail.grandexclusive.com ([127.0.0.1])
        by localhost (mail.grandexclusive.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uOji8BLJ9adB; Sun, 12 Jun 2022 17:58:46 +0700 (+07)
Received: from [107.161.81.135] (unknown [107.161.81.135])
        by mail.grandexclusive.com (Postfix) with ESMTPSA id F1D0D28443A;
        Sun, 12 Jun 2022 17:58:35 +0700 (+07)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Re: Please Read .... ........    
To:     Recipients <gu.kai@reding.com>
From:   "Mrs G. Kailai" <gu.kai@reding.com>
Date:   Sun, 12 Jun 2022 18:58:23 +0800
Reply-To: mail@gukaimail.com
Message-Id: <20220612105835.F1D0D28443A@mail.grandexclusive.com>
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_50,HK_NAME_MR_MRS,
        KHOP_HELO_FCRDNS,RCVD_IN_PSBL,RCVD_IN_SBL,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [203.146.237.187 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
        *      [203.146.237.187 listed in psbl.surriel.com]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [203.146.237.187 listed in bl.score.senderscore.com]
        *  0.7 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.8 HK_NAME_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 KHOP_HELO_FCRDNS Relay HELO differs from its IP's reverse DNS
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,


I want to gve out to Charities in your City, can you refer any to me? Please reply for details.


Ms. Gu Kailai
